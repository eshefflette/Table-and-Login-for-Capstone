//
//  SingleAssignmentViewController.m
//  Login
//
//  Created by Eric Shefflette on 11/8/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "SingleAssignmentViewController.h"

@interface SingleAssignmentViewController ()

@end

@implementation SingleAssignmentViewController
@synthesize courseNameLabel, passedAssignment, finalGradeLabel, gradeMaxLabel, commentView, assignmentNameLabel;

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
    courseNameLabel.text = [passedAssignment valueForKey:@"coursename"];
     if ((NSNull *)[passedAssignment valueForKey:@"assignmentname"] == [NSNull null])
     {
         assignmentNameLabel.text = @"Blank";
     }
     else{
         assignmentNameLabel.text = [passedAssignment valueForKey:@"assignmentname"];

     }
    finalGradeLabel.text = [passedAssignment valueForKey:@"finalgrade"];
    gradeMaxLabel.text = [passedAssignment valueForKey:@"grademax"];
   // commentView.text = [passedAssignment valueForKey:@""];
    [super viewDidLoad];
    //[courseNameLabel setText:[passedAssignment valueForKey:@"coursename"]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
