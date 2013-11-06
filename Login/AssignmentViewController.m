//
//  AssignmentViewController.m
//  iLearnAdvise
//
//  Created by Eric Shefflette on 11/5/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "AssignmentViewController.h"

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
    cell.detailTextLabel.text = [[assignments objectAtIndex:indexPath.row]  objectForKey:@"grademax"];
    cell.textLabel.text = [[assignments objectAtIndex:indexPath.row] objectForKey:@"finalgrade"];
    // }
    return cell;
}

-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [assignments count];
}

@end
