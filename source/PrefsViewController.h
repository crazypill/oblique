
///////////////////////////////////////////////////////////////////////////////
//
// Copyright 2007-2008 Far Out Labs.  All rights reserved.  $Revision: 1.0 $
//      This material is the confidential trade secret and proprietary
//      information of FOLabs.  It may not be reproduced, used,
//      sold or transferred to any third party without the prior written
//      consent of FOLabs.  All rights reserved.
//
///////////////////////////////////////////////////////////////////////////////

/*	History:

26aug08	alx	Created

*/

#import "ObCommon.h"

///////////////////////////////////////////////////////////////////////////////
//
// Constants
//
///////////////////////////////////////////////////////////////////////////////

#define kPrefsNumberOfEditions 5 


///////////////////////////////////////////////////////////////////////////////
//
// Interface
//
///////////////////////////////////////////////////////////////////////////////

@interface PrefsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	UITableView*      mPrefTable;
	UITableViewCell*  mEditions[kPrefsNumberOfEditions];
	
	UITableViewCell*  mAboutGroup;
	UITableViewCell*  mAboutText;
	NSString*         mCopyrightText;
}

@end

// EOF
