//
//  StudentCollectionViewController.m
//  Login
//
//  Created by Eric Shefflette on 11/19/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "StudentCollectionViewController.h"
#import "DetailViewController.h"

@interface StudentCollectionViewController ()

@end

@implementation StudentCollectionViewController

@synthesize students, assignments, students2, classes, cohort, finalGradeHold, finalGradeHoldTwo;

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
    
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(35, 35)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.title = @"Students";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://shefflettetech.com/testmoodle/webservice/rest/server.php?wstoken=5bf740e75ee58d5222263e4ccac9173d&wsfunction=local_test_get_grades_for_cohort_members&moodlewsrestformat=json&cohortids=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSMutableArray *students2 = [NSMutableArray arrayWithObjects: [NSMutableArray array], [NSMutableArray array], nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   // NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    //return [sectionArray count]; }

    return cohort.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  //  return [self.dataArray count];
    
    return 1;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    
    //NSString *cellData = [data objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
  //  return cell;
    
    finalGradeHoldTwo = 0;
    finalGradeHold = 0;
    NSMutableString *holdString = [NSMutableString alloc];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    // UIImageView *imgView = [[[UIImageView] alloc] initWithFrame:CGRect(0,0,20,20)];
    
    //UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,20,20)];
    UIImageView *colorImage = (UIImageView *)[cell viewWithTag:100];

    
    for(id class in [cohort objectAtIndex:indexPath.row])
    {
        for(id assignment in class)
        {
            for(id individualassignment in assignment)
            {
                
                // NSLog(@"tst %d", hold);
                if(finalGradeHold == 0)
                {
                    if ((NSNull *)[individualassignment valueForKey:@"assignmentname"] == [NSNull null])
                    {
                        //      NSLog(@"If statement assignment grade %@", [individualassignment valueForKey:@"finalgrade"]);
                        holdString = [individualassignment valueForKey:@"finalgrade"];
                        finalGradeHold = [holdString doubleValue];
                        //hold = [[individualassignment valueForKey:@"finalgrade"] doubleValue];
                        NSLog(@"If statement hold %f", finalGradeHold);
                    }
                }
                else
                {
                    if ((NSNull *)[individualassignment valueForKey:@"assignmentname"] == [NSNull null])
                    {
                        // double test2 = 0;
                        //   test2 = [[individualassignment valueForKey:@"fianlgrade"] doubleValue];
                        //    NSLog(@"test output of value %d", test2);
                        //     NSLog(@"assignment name: %@",[individualassignment valueForKey:@"assignmentname"]);
                        holdString = [individualassignment valueForKey:@"finalgrade"];
                        finalGradeHoldTwo = [holdString doubleValue];
                        NSLog(@"else state hold2 %f", finalGradeHoldTwo);
                        if(finalGradeHold > finalGradeHoldTwo)
                        {
                            finalGradeHold = finalGradeHoldTwo;
                        }
                        //   NSLog(@"Else statement hold %f", hold);
                        //      NSLog(@"user id and assignment id %@ %@", [individualassignment valueForKey:@"moodleuserid"], [individualassignment valueForKey:@"finalgrade"]);
                        
                        
                    }
                }
            }
            /* if([[students objectAtIndex:indexPath.row ] objectForKey:@"itemname"])
             {
             if(hold > 80)
             {
             imgView.image = [UIImage imageNamed:@"green.png"];
             }
             else if(hold >= 70 && hold <= 80)
             {
             imgView.image = [UIImage imageNamed:@"yellow.png"];
             }
             else
             {
             imgView.image = [UIImage imageNamed:@"red.png"];
             }
             }*/
        }
        // cell.imageView.image = imgView;
    }
    // }
    NSLog(@"Output of final grade %f", finalGradeHold);
   // cell.textLabel.text = [[[[[cohort objectAtIndex:indexPath.row] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0] objectForKey:@"lastname"];
    //cell.detailTextLabel.text = [[[students2 objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"lastname"];
    //  NSString *grade =
    
  //  cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", finalGradeHold];
    if(finalGradeHold > 80)
    {
        NSLog(@"above 80");
        cell.backgroundColor = [UIColor greenColor];
        colorImage.image = [UIImage imageNamed:@"green.png"];
    }
    else if(finalGradeHold >= 70) //&& hold <= 80)
    {
        NSLog(@"above 70");
        cell.backgroundColor = [UIColor yellowColor];
        //cell.
      //  cell.image = [UIImage imageNamed:@"yellow.png"];
       // colorImage.image = [UIImage imageNamed:@"yellow.png"];
    }
    else
    {
        NSLog(@"below 70");
        //cell.backgroundColor = [UIColor redColor];
        colorImage.image = [UIImage imageNamed:@"red.png"];
    }
    // hold = 0;
    return cell;

}


#pragma mark - Connection Functions

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    students = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
   // NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"coursename"]);
   // NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"firstname"]);
    self.assignments = [NSMutableArray array];
    self.students2 = [NSMutableArray array];
    self.classes = [NSMutableArray array];
    self.cohort = [NSMutableArray array];
    NSInteger counter = 0;
    NSArray *hold = [[NSArray alloc] init];
    
    for(id student in students)
    {
        if(counter == 0)
        {
            /*  if ((NSNull *)[student valueForKey:@"assignmentname"] == [NSNull null])
             {
             [student setObject:@"Overall Grade" forKey:@"assignmentname"];
             }
             */
            [assignments addObject:[student mutableCopy]];
            //  NSLog(@"IF STATE %@", [[assignments objectAtIndex:counter] valueForKey:@"lastname"] );
            counter++;
        }
        else
        {
            /*
             if ((NSNull *)[student valueForKey:@"assignmentname"] == [NSNull null])
             {
             [student setObject:@"Overall Grade" forKey:@"assignmentname"];
             }*/
            
            if([[student valueForKey:@"lastname"] isEqualToString:[[assignments objectAtIndex:0] valueForKey:@"lastname"]])
            {
                
                if([[student valueForKey:@"coursename"] isEqualToString:[[assignments objectAtIndex:0] valueForKey:@"coursename"]])
                {
                    [assignments addObject:[student mutableCopy]];
                    //   NSLog(@"%@", [assignments valueForKey:@"lastname"] );
                    
                }
                else
                {
                    [classes addObject:[assignments mutableCopy]];
                    // [students2 addObject:[classes mutableCopy]];
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
                //NSLog(@"ELSE STATEMENT FOR STUDENT2 %@", [students2 objectAtIndex:counter]);
                [assignments addObject:[student mutableCopy]];
                //  NSLog(@"Final grade: %@", [student objectForKey:@"finalgrade"]);
                counter = 0;
            }
        }
        
    }
    /*   for(id student in cohort)
     {
     for(id class in student)
     {
     double finalGradeTotal = 0;
     double gradeMax = 0;
     
     for(id assignment in class)
     {
     for(id singleassign in assignment)
     {
     
     
     NSString *studentGrade = [singleassign valueForKey:@"finalgrade"];
     NSString *assignmentGradeMax = [singleassign valueForKey:@"grademax"];
     double sGrade = [studentGrade doubleValue];
     double gMax = [assignmentGradeMax doubleValue];
     finalGradeTotal += sGrade;
     gradeMax += gMax;
     NSLog(@"Grade Max %g", gradeMax);
     NSLog(@"Final grade %g", finalGradeTotal);
     }
     }
     double percent = finalGradeTotal/gradeMax;
     [class addObject:[NSNumber numberWithDouble:percent]];
     
     
     }
     }*/
    
    
    [self.collectionView reloadData];
    NSLog(@"Login cohort display %@", cohort);
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

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    NSMutableArray *object = [[[cohort objectAtIndex:indexPath.item] objectAtIndex:0] mutableCopy];
    
    NSLog(@"Prepare for segue %@", [[[object objectAtIndex:0] objectAtIndex:1] valueForKey:@"coursename"]);
    detailViewController.stud = object;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
