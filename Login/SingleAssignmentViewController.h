//
//  SingleAssignmentViewController.h
//  Login
//
//  Created by Eric Shefflette on 11/8/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleAssignmentViewController : UIViewController
{
    IBOutlet UILabel *assignmentNameLabel;
    IBOutlet UILabel *finalGradeLabel;
    IBOutlet UILabel *gradeMaxLabel;
    IBOutlet UILabel *courseNameLabel;
    IBOutlet UITextView *commentView;
    NSArray *passedAssignment;
    
}

@property (nonatomic, retain) UILabel *assignmentNameLabel;
@property (nonatomic, retain) UILabel *finalGradeLabel;
@property (nonatomic, retain) UILabel *gradeMaxLabel;
@property (nonatomic, retain) UILabel *courseNameLabel;
@property (nonatomic, retain) UITextView *commentView;
@property (nonatomic, retain) NSArray *passedAssignment;

@end
