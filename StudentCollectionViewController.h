//
//  StudentCollectionViewController.h
//  Login
//
//  Created by Eric Shefflette on 11/19/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentCollectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;


@end
