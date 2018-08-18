
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

#import "PrefsViewController.h"
#import "ObliqueAppDelegate.h"


///////////////////////////////////////////////////////////////////////////////
//
// Constants
//
///////////////////////////////////////////////////////////////////////////////

// define this to see what methods are being called as a delegate or override
//#define CHECK_RESPONSES

static const float kPrefsTableTitleHeight     = 34.0f;
static const float kPrefsTableCopyrightHeight = 94.0f;	// boy, any smaller and I get an ellipsis at the end of the text "sometimes", annoying at best
static const float kPrefsTableAboutHeight     = 69.0f;

#define kPrefsNavTitle           @"Preferences"
#define kPrefsSelectCardDeck     @"Please select a card edition:"

#define kPrefsFirstEditionEntry  @"First Edition"
#define kPrefsSecondEditionEntry @"Second Edition"
#define kPrefsThirdEditionEntry  @"Third Edition"
#define kPrefsFourthEditionEntry @"Fourth Edition"
#define kPrefsFifthEditionEntry  @"Fifth Edition"

#define kPrefsAboutFormat        @"Oblique v%@\nOblique Strategies © Brian Eno and Peter Schmidt\nSoftware © 2008-2018 Far Out Labs LLC\nSoftware written by: Alex Lelièvre\n"


enum
{
	kTableGroup_Editions = 0,
	kTableGroup_About,
	
	// please keep last
	kTableGroup_NumGroups
};


///////////////////////////////////////////////////////////////////////////////
//
// PrefsViewController Implementation
//
///////////////////////////////////////////////////////////////////////////////

@implementation PrefsViewController

- (void)viewDidLoad 
{
}


- (void)didReceiveMemoryWarning 
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


///////////////////////////////////////////////////////////////////////////////

- (id)init
{
    self = [super init];
	if( !self ) 
        return self;

	int currentEdition = [[gApp getDeck] getEdition] + 1;

    CGRect frameRect = [UIScreen mainScreen].bounds;
    frameRect.origin.y += 44.0f; // account for navigation header
    frameRect.size.height -= 44.0f;
    mPrefTable = [[UITableView alloc] initWithFrame:frameRect style:UITableViewStyleGrouped];
    mPrefTable.delegate   = self;
    mPrefTable.dataSource = self;
	
	for( int i = 0; i < kPrefsNumberOfEditions; i++ )
		mEditions[i] = [[UITableViewCell alloc] init];

	mEditions[0].text = kPrefsFirstEditionEntry;
	mEditions[1].text = kPrefsSecondEditionEntry;
	mEditions[2].text = kPrefsThirdEditionEntry;
	mEditions[3].text = kPrefsFourthEditionEntry;
	mEditions[4].text = kPrefsFifthEditionEntry;

	// put copyright text display below 
	mAboutText     = [[UITableViewCell alloc] init];
	
	// setup views
	mCopyrightText = [[gApp getDeck] getCopyright];
	
	// now do about subviews
	UITextView* aboutText = [[UITextView alloc] initWithFrame:CGRectMake( 75.0f, 5.0f, 260.0f, kPrefsTableAboutHeight - 6 )];
	aboutText.editable    = NO;
	aboutText.font        = [UIFont systemFontOfSize:9];
	aboutText.text        = [NSString stringWithFormat:kPrefsAboutFormat, [[[NSBundle mainBundle] infoDictionary] valueForKey:kApplicationVersionKey]];
    aboutText.userInteractionEnabled = NO;
    mAboutText.image      = [UIImage imageNamed:kApplicationAboutIcon];
	mAboutText.font       = [UIFont systemFontOfSize:11];
	[mAboutText.contentView addSubview:aboutText];


	self.view = mPrefTable;
	[mPrefTable reloadData];
	
	// set the current edition
	mEditions[currentEdition - 2].accessoryType = UITableViewCellAccessoryCheckmark;
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	long selectedRow = indexPath.row;

	// lazy way to clear check marks without state
	for( int i = 0; i < kPrefsNumberOfEditions; i++ )
		mEditions[i].accessoryType = UITableViewCellAccessoryNone;
	
	[[gApp getDeck] loadDeck:(ObDeck)(selectedRow + 1)];
	mCopyrightText = [[gApp getDeck] getCopyright];
	mEditions[selectedRow].accessoryType = UITableViewCellAccessoryCheckmark;
	[mPrefTable reloadData];
}


///////////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView 
{
	return kTableGroup_NumGroups;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if( section == kTableGroup_Editions ) 
		return kPrefsNumberOfEditions;
	else if( section == kTableGroup_About ) 
		return 1;
		
	return 0;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if( indexPath.section == kTableGroup_Editions ) 
		return mEditions[indexPath.row];
	else if( indexPath.section == kTableGroup_About )
		return mAboutText;
	
	return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if( section == kTableGroup_Editions )
		return kPrefsSelectCardDeck;
        
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if( section == kTableGroup_Editions )
		return mCopyrightText;

    return nil;
}




- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
	if( section != kTableGroup_Editions )
        return 0;
        
    return kPrefsTableTitleHeight;
}

- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
	if( section != kTableGroup_Editions )
        return 0;
        
    return kPrefsTableCopyrightHeight;
}


- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
	if( indexPath.section == kTableGroup_About )
        return kPrefsTableAboutHeight;
    
	return tableView.rowHeight;
}

///////////////////////////////////////////////////////////////////////////////

#ifdef CHECK_RESPONSES
// !!@ for debugging
- (BOOL)respondsToSelector:(SEL)selector
{
  trace( @"ObPrefsView:respondsToSelector: %s", selector );
  return [super respondsToSelector:selector];
}
#endif

@end

// EOF
