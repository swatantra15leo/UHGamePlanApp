//
//  HelpViewController.m
//  GamePlanApp
//
//  Created by Kowshik Gurram on 11/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "HelpViewController.h"
#import "HelpFullScreenVC.h"


@implementation HelpViewController
@synthesize fullScreenBtnOutlet;

@synthesize myWebView, navigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    myWebView.scalesPageToFit=YES;
    
    NSString *urlAdd = [[NSBundle mainBundle] pathForResource:@"userguide" ofType: @"pdf"];
    NSURL *ur = [NSURL fileURLWithPath:urlAdd]; 
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:ur]; 
    [myWebView loadRequest:requestObj];
    
    // Do any additional setup after loading the view from its ni);
}

- (void)viewDidUnload
{
    [self setMyWebView:nil];
    [self setFullScreenBtnOutlet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)showRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Add the popover button to the left navigation item.
    [navigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
//    [navigationBar.topItem setLeftBarButtonItem:barButtonItem animated:NO];
}


- (void)invalidateRootPopoverButtonItem:(UIBarButtonItem *)barButtonItem {
    // Remove the popover button.
    [navigationBar.topItem setLeftBarButtonItem:nil animated:NO];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}


-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if(UIDeviceOrientationIsPortrait(toInterfaceOrientation))
        [fullScreenBtnOutlet setEnabled:NO];
    else
        [fullScreenBtnOutlet setEnabled:YES];
}


- (void)dealloc {
    [navigationBar release];
    [myWebView release];
    [fullScreenBtnOutlet release];
    [super dealloc];
}
- (IBAction)fullScreenBtn:(id)sender {
    
    HelpFullScreenVC *fullScreenVC = [[HelpFullScreenVC alloc] initWithNibName:@"HelpFullScreenVC" bundle:[NSBundle mainBundle]];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:fullScreenVC];
    nav.navigationBar.tintColor=[[UIColor alloc] initWithRed:(54.0f/255.0f) green:(23.0f/255.0f) blue:(89.0f/255.0f) alpha:1.0f];
    [self presentModalViewController:nav animated:YES];
    
}
@end
