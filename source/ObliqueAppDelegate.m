
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

#import "ObliqueAppDelegate.h"
#import "RootViewController.h"

@implementation ObliqueAppDelegate

@synthesize window;
@synthesize rootViewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
	mStrategies = [[ObStrategies alloc] init];
    
    self.window.rootViewController = rootViewController;
//	[window addSubview:[rootViewController view]];
	[window makeKeyAndVisible];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [mStrategies persistDeck];
}


- (ObStrategies*)getDeck
{
	return mStrategies;
}

@end

// EOF
