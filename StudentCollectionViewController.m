//
//  StudentCollectionViewController.m
//  Login
//
//  Created by Eric Shefflette on 11/19/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "StudentCollectionViewController.h"
#import "DetailViewController.h"
#import "StudentViewController.h"

@interface StudentCollectionViewController ()

@end

@implementation StudentCollectionViewController

@synthesize students, assignments, students2, classes, cohort, finalGradeHold, finalGradeHoldTwo, token, userName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //set the change view button on the top right of toolbar
    UIBarButtonItem* viewButton = [[UIBarButtonItem alloc] initWithTitle:@"View Type" style:UIBarButtonItemStyleBordered target:self action:@selector(viewClick:)];
    [[self navigationItem] setRightBarButtonItem:viewButton];
    
    //connect cell xib with actual view
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
    
    //set view layout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(35, 35)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    //set title of view
    self.title = @"Students";
    //turn on indicator to let user know the network connection IS active
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    /*THIS ALL WORKS IT HAS BEEN COMMENTED TO ALLOW DYNAMIC USE OF POST
     NSURL *url = [NSURL URLWithString:@"http://shefflettetech.com/testmoodle/webservice/rest/server.php?wstoken=5bf740e75ee58d5222263e4ccac9173d&wsfunction=local_test_get_grades_for_cohort_members&moodlewsrestformat=json&cohortids=1"];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     [[NSURLConnection alloc] initWithRequest:request delegate:self];
     
     NSMutableArray *students2 = [NSMutableArray arrayWithObjects: [NSMutableArray array], [NSMutableArray array], nil]; */
    
    //add token to the URL post
    NSString *post =[[NSString alloc] initWithFormat:@"wstoken=%@&username=%@",token, userName];
    //declare url
    NSURL *url=[NSURL URLWithString:@"http://shefflettetech.com/testmoodle/webservice/rest/server.php?wsfunction=local_test_get_grades_for_cohort_members&moodlewsrestformat=json&"];
    //combine postdata and url
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *response = nil;
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return cohort.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    //only returning 1 section, can later add 3. one for each color
    return 1;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    finalGradeHoldTwo = 0;
    finalGradeHold = 0;
    NSMutableString *holdString = [NSMutableString alloc];
    
    UIImageView *colorImage = (UIImageView *)[cell viewWithTag:100];
    
    
    for(id class in [cohort objectAtIndex:indexPath.row])
    {
        for(id assignment in class)
        {
            for(id individualassignment in assignment)
            {
                
                if(finalGradeHold == 0)
                {
                    if ((NSNull *)[individualassignment valueForKey:@"assignmentname"] == [NSNull null])
                    {
                        holdString = [individualassignment valueForKey:@"finalgrade"];
                        finalGradeHold = [holdString doubleValue];
                    }
                }
                else
                {
                    if ((NSNull *)[individualassignment valueForKey:@"assignmentname"] == [NSNull null])
                    {
                        holdString = [individualassignment valueForKey:@"finalgrade"];
                        finalGradeHoldTwo = [holdString doubleValue];
                        if(finalGradeHold > finalGradeHoldTwo)
                        {
                            finalGradeHold = finalGradeHoldTwo;
                        }
                    }
                }
            }
        }
    }
    
    if(finalGradeHold > 80)
    {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"green.png"]];
        
    }
    else if(finalGradeHold >= 70)
    {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"yellow.png"]];
        
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"red.png"]];
    }
    
    return cell;
    
}


#pragma mark - Connection Functions

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    students = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    self.assignments = [NSMutableArray array];
    self.students2 = [NSMutableArray array];
    self.classes = [NSMutableArray array];
    self.cohort = [NSMutableArray array];
    NSInteger counter = 0;
    
    for(id student in students)
    {
        if(counter == 0)
        {
            [assignments addObject:[student mutableCopy]];
            counter++;
        }
        else
        {
            if([[student valueForKey:@"lastname"] isEqualToString:[[assignments objectAtIndex:0] valueForKey:@"lastname"]])
            {
                
                if([[student valueForKey:@"coursename"] isEqualToString:[[assignments objectAtIndex:0] valueForKey:@"coursename"]])
                {
                    [assignments addObject:[student mutableCopy]];
                    
                }
                else
                {
                    [classes addObject:[assignments mutableCopy]];
                    [assignments removeAllObjects];
                    [assignments addObject:[student mutableCopy]];
                }
            }
            else
            {
                [classes addObject:[assignments mutableCopy]];
                [students2 addObject:[classes mutableCopy]];
                [classes removeAllObjects];
                [assignments removeAllObjects];
                [cohort addObject:[students2 mutableCopy]];
                [students2 removeAllObjects];
                [assignments addObject:[student mutableCopy]];
                counter = 0;
            }
        }
        
    }
    
    [self.collectionView reloadData];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Coul not establish a connection to the server. " delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [errorView show];
    
}

#pragma mark - Selection and Cell Functions

//when a user selects item push new view controller and pass the student data
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    NSMutableArray *object = [[[cohort objectAtIndex:indexPath.item] objectAtIndex:0] mutableCopy];
    
    NSLog(@"Prepare for segue %@", [[[object objectAtIndex:0] objectAtIndex:1] valueForKey:@"coursename"]);
    detailViewController.stud = object;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

//set the margins around edge of view controller. Keeps things from getting pushed all the way to the edge of screen
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//push new view controller if user clicks to change views, passing username and token along with
- (IBAction)viewClick:(id)sender
{
    StudentViewController *studentViewController = [[StudentViewController alloc] initWithNibName:@"StudentViewController" bundle:nil];
    studentViewController.userName = userName;
    studentViewController.token = token;
    [self.navigationController pushViewController:studentViewController animated:YES];
    
}
@end
