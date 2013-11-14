//
//  DetailViewController.h
//  iLearnAdvise
//
//  Created by Eric Svendsen Shefflette on 9/4/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StudentViewController.h"

@interface DetailViewController : UIViewController
{
    IBOutlet UITableView *mainTableView;
    
    NSMutableArray *stud;
    double finalGradeHold;
    double finalGradeHoldTwo;
}

@property (nonatomic, retain) NSMutableArray *stud;
@property (nonatomic) double finalGradeHold;
@property (nonatomic) double finalGradeHoldTwo;
@end
