//
//  ViewController.h
//  iLearnAdvise
//
//  Created by Eric Svendsen Shefflette on 9/4/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentViewController : UIViewController

{
    IBOutlet UITableView *mainTableView;
    
    NSArray *students;
    NSMutableData *data;
    NSMutableArray *assignments;
    NSMutableArray *students2;
    NSMutableArray *classes;
    NSMutableArray *cohort;
    
}

@property (nonatomic, retain) NSArray *students;
@property (nonatomic, retain) NSMutableArray *assignments;
@property (nonatomic, retain) NSMutableArray *students2;
@property (nonatomic, retain) NSMutableArray *classes;
@property (nonatomic, retain) NSMutableArray *cohort;

@end
