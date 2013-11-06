//
//  ViewController.m
//  Login
//
//  Created by Eric Svendsen Shefflette on 9/8/13.
//  Copyright (c) 2013 Eric Svendsen Shefflette. All rights reserved.
//

#import "ViewController.h"
#import "StudentViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize usernameText, result, passwordText, token, username;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClick:(id)sender {
  //  @try {
        
        if([[usernameText text] isEqualToString:@""] || [[passwordText text] isEqualToString:@""] ) {
            [self alertStatus:@"Please enter both Username and Password" :@"Login Failed!"];
        }
        else {
            username = [usernameText text];
            NSLog(@"username display %@", username);
       //     NSURL *url = [NSURL URLWithString:@"http://shefflettetech.com/testmoodle/webservice/rest/server.php?wstoken=5bf740e75ee58d5222263e4ccac9173d&wsfunction=//local_test_get_grades_for_cohort_members&moodlewsrestformat=json&cohortids=1"];
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
  //          [[NSURLConnection alloc] initWithRequest:request delegate:self];
            
            
            NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@",[usernameText text],[passwordText text]];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:@"http://shefflettetech.com/testmoodle/login/token.php?service=moodle_mobile_app&"];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
       
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            NSLog(@"URL DATA %@", urlData);
      //      NSLog(@"Response code: %d", [response statusCode]);
            result = [NSJSONSerialization JSONObjectWithData:urlData options:nil error:nil];
            NSLog(@"TOKEN------%@", result);
            NSLog(@"status code %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
               // NSData *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                //NSLog(@"Response ==> %@", responseData);
                
                //NSJSONSerialization *jsonParser = [NSJSONSerialization new];
               //result = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
                //NSLog(@"%@",result);
                //NSInteger success = [(NSNumber *) [[result objectAtIndex:0] objectForKey:@"token"] integerValue];
                //NSLog(@"%d",success);
                if([result valueForKey:@"token"])
                {
                    token = [result valueForKey:@"token"];
                    NSLog(@"Output after storing token %@", token);
                    NSLog(@"Login SUCCESS");
                    //[self alertStatus:@"Logged in Successfully." :@"Login Success!"];
                    StudentViewController *studentViewController = [[StudentViewController alloc] initWithNibName:@"StudentViewController" bundle:nil];
                    [self presentViewController:studentViewController animated:YES completion:nil];
                } else {
                    
                   // NSString *error_msg = (NSString *) [jsonData objectForKey:@"error_message"];
                    [self alertStatus:@"Login Failed!" :@"Login FAILED"];
                }
                
            } else {
                if (error) NSLog(@"Error: %@", error);
                [self alertStatus:@"Connection Failed" :@"Login Failed!"];
            }
        }
   // }
   // @catch (NSException * e) {
   //     NSLog(@"Exception: %@", e);
   //     [self alertStatus:@"Login Failed." :@"Login Failed!"];

   // }
    

}
- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}



- (IBAction)backgroundClearClick:(id)sender {
 
    [usernameText resignFirstResponder];
    
    [passwordText resignFirstResponder];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    result = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
    //NSLog(@"TEST!!");
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
  //  NSLog(@"TOKEN------%@", [[result objectAtIndex:0] objectForKey:@"token"]);
    //NSLog(@"%@", [[students objectAtIndex:0] objectForKey:@"firstname"]);
    //[mainTableView reloadData];
    
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)theData
{
    [data appendData:theData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Connection failed to receive a response" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [errorView show];
    
}

@end
