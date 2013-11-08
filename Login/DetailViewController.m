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

@synthesize stud;

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
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
