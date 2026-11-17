
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

#import "MainViewController.h"
#import "SceneDelegate.h"
#import "ObCardView.h"

@implementation MainViewController


- (id)init
{
    self = [super init];
	if( !self )
        return self;
    
    CGRect oldRect = CGRectMake( 0, 0, 320, 480 );
    self.view = [[ObCardView alloc] initWithFrame:oldRect];
//    self.view = [[ObCardView alloc] initWithFrame:SceneDelegate.getWindowRect];

	return self;
}



//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
//{
//	return UIInterfaceOrientationIsLandscape( interfaceOrientation );
//}


- (void)didReceiveMemoryWarning 
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


@end

// EOF
