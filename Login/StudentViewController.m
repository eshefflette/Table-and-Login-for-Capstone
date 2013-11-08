//
//  ViewController.m
//  iLearnAdvise
//
//  Created by Eric Svendsen Shefflette on 9/4/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "StudentViewController.h"
#import "DetailViewController.h"

NSString *kDetailedViewControllerID = @"DetailView";    // view controller storyboard id
NSString *kCellID = @"cellID";

@interface StudentViewController ()

@end

@implementation StudentViewController

@synthesize students, assignments, students2, classes, cohort;

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
    self.title = @"Students";
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURL *url = [NSURL URLWithString:@"http://shefflettetech.com/testmoodle/webservice/rest/server.php?wstoken=5bf740e75ee58d5222263e4ccac9173d&wsfunction=local_test_get_grades_for_cohort_members&moodlewsrestformat=json&cohortids=1"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    NSMutableArray *students2 = [NSMutableArray arrayWithObjects: [NSMutableArray array], [NSMutableArray array], nil];
    //[self.mainTableView registerClass:[UITableViewCell class] forCellWithReuseIdentifier:@"kCellID"];
	// Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Connection Functions

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    students = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"coursename"]);
    NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"firstname"]);
    self.assignments = [NSMutableArray array];
    self.students2 = [NSMutableArray array];
    self.classes = [NSMutableArray array];
    self.cohort = [NSMutableArray array];
    NSInteger counter = 0;
    NSArray *hold = [[NSArray alloc] init];

    for(id student in students)
    {
        NSLog(@"End of if statement name and class %@", [student valueForKey:@"coursename"]);
        NSLog(@"student name %@", [student valueForKey:@"lastname"]);
        if(counter == 0)
        {
            [assignments addObject:[student mutableCopy]];
          //  NSLog(@"IF STATE %@", [[assignments objectAtIndex:counter] valueForKey:@"lastname"] );
            counter++;
        }
        else
        {
            
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
                counter = 0;
            }
        }
    
    }
    NSLog(@"Cohort before reload %@", cohort);
    for(id student in cohort)
    {
        //NSLog(@"Students name %@", [[[[[student objectAtIndex:1] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0] valueForKey:@"lastnmae"]);
    }
    [mainTableView reloadData];
    
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


#pragma mark - Table View Components

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    // if([[students objectAtIndex:indexPath.row ] objectForKey:@"itemname"] != [NSNull null])
    //{
    cell.textLabel.text = [[[[[cohort objectAtIndex:indexPath.row] objectAtIndex:0] objectAtIndex:0] objectAtIndex:0] objectForKey:@"lastname"];
    //cell.detailTextLabel.text = [[[students2 objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"lastname"];
    // }
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cohort.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    NSMutableArray *object = [[[cohort objectAtIndex:indexPath.row] objectAtIndex:0] mutableCopy];
    
    NSLog(@"Prepare for segue %@", [[[object objectAtIndex:0] objectAtIndex:1] valueForKey:@"coursename"]);
    detailViewController.stud = object;
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
