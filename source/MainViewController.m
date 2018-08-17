
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
#import "ObCardView.h"

@implementation MainViewController


- (id)init
{
    self = [super init];
	if( !self )
        return self;
        
    self.view = [[ObCardView alloc] initWithFrame:[UIScreen mainScreen].bounds];

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


- (void)dealloc 
{
	[super dealloc];
}


@end

// EOF
