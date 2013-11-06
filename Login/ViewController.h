//
//  ViewController.h
//  Login
//
//  Created by Eric Svendsen Shefflette on 9/8/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSArray *result;
    NSMutableData *data;
    NSString *token;
    NSString *username;
}

@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (nonatomic, retain) NSArray *result;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (nonatomic, retain) NSString *token;
@property (nonatomic, retain) NSString *username;
- (IBAction)loginClick:(id)sender;
- (IBAction)backgroundClearClick:(id)sender;


@end
