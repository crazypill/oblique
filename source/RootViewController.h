
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

@class MainViewController;
@class PrefsViewController;

@interface RootViewController : UIViewController 
{
	MainViewController*   mCardController;
	PrefsViewController*  mPrefsController;
	UIButton*             mInfoButton;
	UINavigationBar*      mPrefsNavigationBar;
}

@property (nonatomic, retain) UIButton*            mInfoButton;
@property (nonatomic, retain) UINavigationBar*     mPrefsNavigationBar;
@property (nonatomic, retain) MainViewController*  mCardController;
@property (nonatomic, retain) PrefsViewController* mPrefsController;

- (IBAction)toggleView;

@end

// EOF
