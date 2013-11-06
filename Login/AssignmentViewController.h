//
//  AssignmentViewController.h
//  iLearnAdvise
//
//  Created by Eric Shefflette on 11/5/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssignmentViewController : UIViewController
{
    IBOutlet UITableView *mainTableView;
    NSMutableArray *assignments;
}

@property (nonatomic, retain) NSMutableArray *assignments;

@end
