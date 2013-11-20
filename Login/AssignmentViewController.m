//
//  AssignmentViewController.m
//  iLearnAdvise
//
//  Created by Eric Shefflette on 11/5/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "AssignmentViewController.h"
#import "SingleAssignmentViewController.h"
#import "StudentCollectionViewController.h"

@interface AssignmentViewController ()

@end

@implementation AssignmentViewController

@synthesize assignments;

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
    self.title = [[assignments objectAtIndex:0] valueForKey:@"coursename"];
   // NSLog(@"After segue %@", stud);
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // lastname.text = [student objectForKey:@"lastname"];
    
}

#pragma mark - Table View Components

-(int)numberOfSectionsInTableView:(UITableView *)tableView
{
  //  NSLog(@"Stud %@", stud);
 //   NSLog(@"Stud count %D", stud.count);
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
    //   cell.textLabel.text = [[students objectAtIndex:indexPath.row] objectForKey:@"itemname"];
 //   NSLog(@"Detail view name %@", [[[stud objectAtIndex:indexPath.row] objectAtIndex:0] objectForKey:@"coursename"]);
    cell.detailTextLabel.text = [[assignments objectAtIndex:indexPath.row]  objectForKey:@"finalgrade"];
    NSLog(@"Assignment name %@", [[assignments objectAtIndex:indexPath.row] objectForKey:@"assignmentname"]);
    if ((NSNull *)[[assignments objectAtIndex:indexPath.row] valueForKey:@"assignmentname"] == [NSNull null])    {
        cell.textLabel.text = @"Blank";
    }else
    {
    cell.textLabel.text = [[assignments objectAtIndex:indexPath.row] objectForKey:@"assignmentname"];
    }
    // }
    return cell;
    
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [assignments count];
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleAssignmentViewController *detailViewController = [SingleAssignmentViewController alloc];
    detailViewController.passedAssignment = [assignments objectAtIndex:indexPath.row];
    detailViewController.courseNameLabel.text = [[assignments objectAtIndex:indexPath.row] valueForKey:@"coursename"];
    detailViewController.assignmentNameLabel = [[assignments objectAtIndex:indexPath.row] valueForKey:@"assignmentname"];
    detailViewController.finalGradeLabel = [[assignments objectAtIndex:indexPath.row] valueForKey:@"finalegrade"];
    detailViewController.gradeMaxLabel = [[assignments objectAtIndex:indexPath.row] valueForKey:@"grademax"];
    [self.navigationController pushViewController:detailViewController animated:YES];
}*/


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StudentCollectionViewController *detailViewController = [StudentCollectionViewController alloc];
    [self.navigationController pushViewController:detailViewController animated:YES];
}




@end
