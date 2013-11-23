//
//  StudentCollectionViewController.h
//  Login
//
//  Created by Eric Shefflette on 11/19/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    IBOutlet UICollectionView *collectionView;
    NSArray *students;
    NSMutableData *data;
    NSMutableArray *assignments;
    NSMutableArray *students2;
    NSMutableArray *classes;
    NSMutableArray *cohort;
    double finalGradeHold;
    double finalGradeHoldTwo;
}
- (IBAction)viewClick:(id)sender;
@property (nonatomic, retain) NSArray *students;
@property (nonatomic, retain) NSMutableArray *assignments;
@property (nonatomic, retain) NSMutableArray *students2;
@property (nonatomic, retain) NSMutableArray *classes;
@property (nonatomic, retain) NSMutableArray *cohort;
@property (nonatomic) double finalGradeHold;
@property (nonatomic) double finalGradeHoldTwo;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;


@end
