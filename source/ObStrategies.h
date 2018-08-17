
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

27sep07	alx	Created

*/

///////////////////////////////////////////////////////////////////////////////
//
// Includes
//
///////////////////////////////////////////////////////////////////////////////

#import <UIKit/UIKit.h>


///////////////////////////////////////////////////////////////////////////////
//
// Defines
//
///////////////////////////////////////////////////////////////////////////////


typedef enum
{
	kObDeck_FirstEdition = 1,
	kObDeck_SecondEdition,
	kObDeck_ThirdEdition,
	kObDeck_FourthEdition,
    kObDeck_FifthEdition
} ObDeck;


///////////////////////////////////////////////////////////////////////////////
//
// Interfaces
//
///////////////////////////////////////////////////////////////////////////////

@interface ObStrategies : NSObject 
{
	NSString*		mCopyright;
	NSMutableArray*	mCardArray;
	unsigned char*  mDeck;
	int             mCurrentCard;
	ObDeck          mEdition;
    unsigned int    mDeckLoaded : 1;
}
- (id)        init;
- (void)      loadDeck:(ObDeck)deck;
- (void)      restoreFromPrefs;	// reads our one pref
- (void)      readDeck:(NSString*)path;
- (void)      dumpDeck;
- (void)      shuffleDeck;
- (void)      persistDeck;		// saves to prefs
- (NSString*) getRandomCard;
- (NSString*) getCopyright;
- (ObDeck)    getEdition;
- (void)      dealloc;
@end

// EOF
