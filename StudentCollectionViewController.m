//
//  StudentCollectionViewController.m
//  Login
//
//  Created by Eric Shefflette on 11/19/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "StudentCollectionViewController.h"

@interface StudentCollectionViewController ()

@end

@implementation StudentCollectionViewController

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
   
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(35, 35)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [self.collectionView setCollectionViewLayout:flowLayout];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   // NSMutableArray *sectionArray = [self.dataArray objectAtIndex:section];
    //return [sectionArray count]; }

    return 1;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  //  return [self.dataArray count];
    
    return 1;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
   // NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
    
    //NSString *cellData = [data objectAtIndex:indexPath.row];
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:100];
    
    [titleLabel setText:@"test"];
    
    return cell;
    
}
@end
