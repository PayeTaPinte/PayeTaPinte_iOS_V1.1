//
//  PayeTaPinteViewController.m
//  PayeTaPinte-WV
//
//  Created by MBerthelot-iMac on 01/05/2014.
//  Copyright (c) 2014 MBerthelot-iMac. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()

@property (strong, nonatomic) UIView *loaderContainer;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
    
    // Set Loader
    
    self.loaderContainer = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.loaderContainer.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    [self.view addSubview:self.loaderContainer];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    //self.activityIndicator.frame = CGRectMake(150, 200, CGRectGetWidth(self.activityIndicator.frame), CGRectGetHeight(self.activityIndicator.frame) );
    self.activityIndicator.center = self.loaderContainer.center;
    self.activityIndicator.hidden = NO;
    [self.loaderContainer addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}

-(void)reachabilityChanged:(NSNotification*)note
{
    Reachability * reach = [note object];
    
    if([reach isReachable])
    {
        NSLog(@"Notification Says Reachable");
        [self loadWebview];
    }
    else
    {
        
        NSLog(@"Notification Says Unreachable");
        [self showAlert];
    }
}



-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


#pragma mark - private method
- (void)loadWebview{
    NSString *fullURL = @"http://app.payetapinte.fr";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.viewWeb loadRequest:requestObj];
    self.viewWeb.scrollView.scrollEnabled = NO;
    self.viewWeb.delegate = self;
    
}

- (void)showAlert{
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Erreur"
                                                      message:@"Vous devez être connecté à Internet :)"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

#pragma mark - UIWebViewDelegate Method

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"loaded nebro");
    [self.activityIndicator stopAnimating];
    [self.loaderContainer removeFromSuperview];
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error : %@", error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
