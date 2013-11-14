//
//  DetailViewController.m
//  iLearnAdvise
//
//  Created by Eric Svendsen Shefflette on 9/4/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "DetailViewController.h"
#import "AssignmentViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize stud, finalGradeHold, finalGradeHoldTwo;

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
    self.title = [[[stud objectAtIndex:0] objectAtIndex:0] valueForKey:@"lastname"];
    NSLog(@"After segue %@", stud);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // lastname.text = [student objectForKey:@"lastname"];
    
}

#pragma mark - Table View Components

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"Stud %@", stud);
    NSLog(@"Stud count %D", stud.count);
    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    finalGradeHold = 0;
    finalGradeHoldTwo = 0;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    NSMutableString *holdString = [NSMutableString alloc];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }
    // if([[students objectAtIndex:indexPath.row ] objectForKey:@"itemname"] != [NSNull null])
    //{
    //   cell.textLabel.text = [[students objectAtIndex:indexPath.row] objectForKey:@"itemname"];
    NSLog(@"Detail view name %@", [[[stud objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"coursename"]);
    //  cell.detailTextLabel.text = [[[stud objectAtIndex:indexPath.row]  objectAtIndex:0] objectForKey:@"finalgrade"];
    cell.textLabel.text = [[[stud objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"coursename"];
    // }
    
    for(id individualassignment in [stud objectAtIndex:indexPath.row])
    {
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", finalGradeHold];
    
    if(finalGradeHold > 80)
    {
        NSLog(@"above 80");
        cell.imageView.image = [UIImage imageNamed:@"green.png"];
    }
    else if(finalGradeHold >= 30) //&& hold <= 80)
    {
        NSLog(@"above 70");
        cell.imageView.image = [UIImage imageNamed:@"yellow.png"];
    }
    else
    {
        NSLog(@"below 70");
        cell.imageView.image = [UIImage imageNamed:@"red.png"];
    }
    
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [stud count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssignmentViewController *detailViewController = [[AssignmentViewController alloc] initWithNibName:@"AssignmentViewController" bundle:nil];
    
    //detailViewController.course.text = [[students objectAtIndex:indexPath.row] objectForKey:@"lastname"];
    detailViewController.assignments = [stud objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
    
}

@end
