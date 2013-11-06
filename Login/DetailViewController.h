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
    
}

@property (nonatomic, retain) NSMutableArray *stud;

@end
