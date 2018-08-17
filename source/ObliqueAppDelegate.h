
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

#import "ObCommon.h"
#import "ObStrategies.h"

@class RootViewController;

@interface ObliqueAppDelegate : NSObject <UIApplicationDelegate> 
{
	IBOutlet UIWindow*           window;
	IBOutlet RootViewController* rootViewController;
    
    ObStrategies*                mStrategies;
}

@property (nonatomic, retain) UIWindow*           window;
@property (nonatomic, retain) RootViewController* rootViewController;

- (ObStrategies*)getDeck;

@end

// EOF
