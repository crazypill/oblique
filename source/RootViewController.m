
///////////////////////////////////////////////////////////////////////////////
//
// Copyright 2007 Far Out Labs.  All rights reserved.  $Revision: 1.0 $
//      This material is the confidential trade secret and proprietary
//      information of FOLabs.  It may not be reproduced, used,
//      sold or transferred to any third party without the prior written
//      consent of FOLabs.  All rights reserved.
//
///////////////////////////////////////////////////////////////////////////////

/*	History:

01jun08	alx	Created

*/


///////////////////////////////////////////////////////////////////////////////
//
// Includes
//
///////////////////////////////////////////////////////////////////////////////

#import "RootViewController.h"
#import "MainViewController.h"
#import "PrefsViewController.h"


@implementation RootViewController

@synthesize mInfoButton;
@synthesize mPrefsNavigationBar;
@synthesize mCardController;
@synthesize mPrefsController;


- (void)viewDidLoad 
{
	MainViewController* viewController = [[MainViewController alloc] init];
	mCardController = viewController;
	
	[self.view addSubview:mCardController.view];

	self.mInfoButton  = [UIButton buttonWithType:UIButtonTypeInfoLight];
    mInfoButton.frame = CGRectMake( 6.0f, 452.0f, 20.0f, 20.0f );
    mInfoButton.showsTouchWhenHighlighted = YES;
	[mInfoButton addTarget:self action:@selector(toggleView) forControlEvents:UIControlEventTouchUpInside];

    // rotate button
    mInfoButton.transform = CGAffineTransformMake( 0.0, 1.0, -1.0, 0.0, 0.0f, 0.0f );
	
	[self.view insertSubview:mInfoButton aboveSubview:mCardController.view];
}


- (void)loadPrefsViewController 
{
	PrefsViewController* viewController = [[PrefsViewController alloc] init];
	mPrefsController = viewController;
	
	// Set up the navigation bar
	UINavigationBar* aNavigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	aNavigationBar.barStyle = UIBarStyleBlackOpaque;
	mPrefsNavigationBar = aNavigationBar;
	
	UIBarButtonItem*  buttonItem      = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleView)];
	UINavigationItem* navigationItem  = [[UINavigationItem alloc] initWithTitle:@"Oblique"];
	navigationItem.rightBarButtonItem = buttonItem;
	[mPrefsNavigationBar pushNavigationItem:navigationItem animated:NO];
	[navigationItem release];
	[buttonItem release];
}


- (IBAction)toggleView 
{	
	/*
	 This method is called when the info or Done button is pressed.
	 It flips the displayed view from the main view to the flipside view and vice-versa.
	 */
	if( mPrefsController == nil) 
		[self loadPrefsViewController];
	
	UIView* mainView     = mCardController.view;
	UIView* flipsideView = mPrefsController.view;
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1];
	[UIView setAnimationTransition:([mainView superview] ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:self.view cache:YES];
	
	if ([mainView superview] != nil) 
    {
		[mPrefsController viewWillAppear:YES];
		[mCardController viewWillDisappear:YES];
		[mainView removeFromSuperview];
        [mInfoButton removeFromSuperview];
		[self.view addSubview:flipsideView];
		[self.view insertSubview:mPrefsNavigationBar aboveSubview:flipsideView];
		[mCardController viewDidDisappear:YES];
		[mPrefsController viewDidAppear:YES];

	} 
    else 
    {
		[mCardController viewWillAppear:YES];
		[mPrefsController viewWillDisappear:YES];
		[flipsideView removeFromSuperview];
		[mPrefsNavigationBar removeFromSuperview];
		[self.view addSubview:mainView];
		[self.view insertSubview:mInfoButton aboveSubview:mCardController.view];
		[mPrefsController viewDidDisappear:YES];
		[mCardController viewDidAppear:YES];
	}
	[UIView commitAnimations];
}



//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
//{
//	// Return YES for supported orientations
//	return UIInterfaceOrientationIsLandscape( interfaceOrientation );
//}


- (void)didReceiveMemoryWarning 
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc 
{
	[mInfoButton release];
	[mPrefsNavigationBar release];
	[mCardController release];
	[mPrefsController release];
	[super dealloc];
}


@end

// EOF
