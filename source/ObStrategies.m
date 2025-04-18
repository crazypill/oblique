
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

18sep07	alx	Created

*/


///////////////////////////////////////////////////////////////////////////////
//
// Includes
//
///////////////////////////////////////////////////////////////////////////////

#import "ObStrategies.h"
#import "ObCommon.h"


///////////////////////////////////////////////////////////////////////////////
//
// Constants
//
///////////////////////////////////////////////////////////////////////////////

const long kLineBufferMax = 1024;	// this is much bigger than it needs to be !!@

#define kDeckName_First  @"Strategies1"
#define kDeckName_Second @"Strategies2"
#define kDeckName_Third  @"Strategies3"
#define kDeckName_Fourth @"Strategies4"
#define kDeckName_Fifth  @"Strategies5"

#define kDeckFileType    @"txt"



///////////////////////////////////////////////////////////////////////////////
//
// Implementation
//
///////////////////////////////////////////////////////////////////////////////

@implementation ObStrategies


- (id)init
{
    self = [super init];
    if( !self )
        return self;
 
    mDeckLoaded = NO;       
    [self restoreFromPrefs];
    [self loadDeck:mEdition];
	return self;
}

- (void) dealloc
{
	if( mDeck )
		free( mDeck );
}


///////////////////////////////////////////////////////////////////////////////

- (void)loadDeck:(ObDeck)deck
{
	NSString* basepath;
	
	switch( deck )
	{
		case kObDeck_FirstEdition:
			basepath = [[NSBundle mainBundle] pathForResource:kDeckName_First ofType:kDeckFileType];
			break;
		case kObDeck_SecondEdition:
			basepath = [[NSBundle mainBundle] pathForResource:kDeckName_Second ofType:kDeckFileType];
			break;
		case kObDeck_ThirdEdition:
			basepath = [[NSBundle mainBundle] pathForResource:kDeckName_Third ofType:kDeckFileType];
			break;
		case kObDeck_FourthEdition:
			basepath = [[NSBundle mainBundle] pathForResource:kDeckName_Fourth ofType:kDeckFileType];
			break;
		default:
		case kObDeck_FifthEdition:
			basepath = [[NSBundle mainBundle] pathForResource:kDeckName_Fifth ofType:kDeckFileType];
			break;
	}

    // store as current edition!
    mEdition = deck;

	// load that deck into this object...
	[self readDeck:basepath];
}


- (void)readDeck:(NSString*)path
{
	// if mCount is non-zero we already have a deck installed
	if( [mCardArray count] )
		[self dumpDeck];

	// reseed the random number generator...
	srand( (unsigned int)time(0) );
	rand();			// call it once to wake it up !!@ weird !!@

	// allocate array for all the card text
	if( !mCardArray )
		mCardArray = [[NSMutableArray alloc] init];
	assert( mCardArray );
	
	// open target file
	FILE* cardFile = fopen( [path UTF8String], "r" );
	assert( cardFile );

	// start off getting the copyright string and then skip a newline
	char line[kLineBufferMax];
	fgets( line, kLineBufferMax, cardFile );
	mCopyright = [[NSString alloc] initWithBytes:line length:strlen( line ) encoding:NSMacOSRomanStringEncoding];
	
	while( fgets( line, kLineBufferMax, cardFile ) != NULL ) 
	{
		// allocate a string for our array and copy this line in there...
		[mCardArray addObject:[[NSString alloc] initWithBytes:line length:strlen( line ) encoding:NSMacOSRomanStringEncoding]];
	}
	fclose( cardFile );

    if( !mDeckLoaded )
        [self shuffleDeck];
    
    // reset
    mDeckLoaded = NO;
}


- (void)dumpDeck
{
//	trace( "dumping deck: %ld\n", [mCardArray count] );
	[mCardArray removeAllObjects];
}


- (bool)isDuplicate:(int)index
{
	int i;
	
	// linear search for the number in the current array - we only want one of each card
	for( i = 0; i < [mCardArray count]; i++ )
	{
		if( mDeck[i] == index )
			return true;
	}
	
	return false;
}

- (int)randomNumber
{
	// create a random number in the range of our number of cards in the deck
	// oh- we use doubles to avoid integer overflow.
	double nugget = rand() / ((double)RAND_MAX + 1.0);

	// just truncate, rounding up would be bad here
	return (int)(nugget * [mCardArray count]);
}


- (void)shuffleDeck
{
	unsigned long cardCount = [mCardArray count];
	
	// reset
	mCurrentCard = 0;
	
	// check for current deck and kill it, might be the wrong size
	if( mDeck )
		free( mDeck );
	
	// this could be done with a resize but I'm lazy and how often do people shuffle or change decks?
	mDeck = malloc( sizeof( unsigned char ) * cardCount );
	memset( mDeck, -1, sizeof( unsigned char ) * cardCount );
	assert( mDeck );
	
	int i;
	for( i = 0; i < cardCount; i++ )
	{
		int randomIndex = [self randomNumber];
		
		// don't allow duplicate cards in this deck
		while( [self isDuplicate:randomIndex] )
			randomIndex = [self randomNumber];

		assert( randomIndex >= 0 && randomIndex < cardCount );
		
		// ok- so it's not in the deck already, so plop it in there
		mDeck[i] = randomIndex;
	}
}


///////////////////////////////////////////////////////////////////////////////

// this method returns a card at random
- (NSString*)getRandomCard
{
	// get an index from the deck and then look up that index in the cards
	NSString* randomCard = [mCardArray objectAtIndex:mDeck[mCurrentCard]];
	
	// reshuffle the deck here
	if( ++mCurrentCard >= [mCardArray count] )
		[self shuffleDeck];
	
	return randomCard;
}

- (NSString*)getCopyright
{
	return mCopyright;
}

- (ObDeck)getEdition
{
	return mEdition;
}


///////////////////////////////////////////////////////////////////////////////

- (void)writeDeckOrder
{
    // point to deck order file if there is one
	NSString*     fileName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kApplicationIDKey];
	NSString*     path     = [[NSString stringWithFormat:@"~/Library/Preferences/%@.deck", fileName] stringByExpandingTildeInPath];
    
    // try to open the file and write it
    FILE* deckOrder = fopen( [path UTF8String], "wb" );
    
    if( deckOrder )
    {
        // write the number of entries.
        unsigned char numEntries = mCardArray.count;
        fwrite( &numEntries, sizeof( numEntries ), 1, deckOrder );
        fwrite( mDeck, sizeof( numEntries ), numEntries, deckOrder );
        fclose( deckOrder );
    }
}


- (void)restoreDeckOrder
{
    // point to deck order file if there is one
	NSString*     fileName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kApplicationIDKey];
	NSString*     path     = [[NSString stringWithFormat:@"~/Library/Preferences/%@.deck", fileName] stringByExpandingTildeInPath];
    
    // try to open the file and read it
    FILE* deckOrder = fopen( [path UTF8String], "rb" );
    if( deckOrder )
    {
        // just read the number of entries.
        unsigned char numEntries = 0;
        if( fread( &numEntries, sizeof( numEntries ), 1, deckOrder ) == 1 )
        {
            if( numEntries )
            {
                // check for current deck and kill it, might be the wrong size
                if( mDeck )
                    free( mDeck );
                
                // this could be done with a resize but I'm lazy and how often do people shuffle or change decks?
                mDeck = malloc( sizeof( unsigned char ) * numEntries );
                assert( mDeck );
                
                if( fread( mDeck, sizeof( numEntries ), numEntries, deckOrder ) == numEntries )
                    mDeckLoaded = YES;
            }
        }
        
        fclose( deckOrder );
    }
}


- (void)restoreFromPrefs
{
	// create path reference
	NSString*     fileName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kApplicationIDKey];
	NSString*     path     = [NSString stringWithFormat:@"~/Library/Preferences/%@", fileName];

	// get prefs dictionary
	NSDictionary* d        = [NSDictionary dictionaryWithContentsOfFile:[path stringByExpandingTildeInPath]];
	
	if( d )
	{
        NSNumber* card = [d objectForKey: @"currentCard"];
        if( card )
            mCurrentCard = [card intValue];
        
		// grab the edition key
		NSNumber* edition = [d objectForKey: @"edition"];
        if( edition )
            mEdition = [edition intValue];
        
        [self restoreDeckOrder];
        return;
	}
	
	// default to fifth edition deck
	mEdition = kObDeck_FifthEdition;
    mCurrentCard = 0;
}


- (void)persistDeck
{
	// create prefs dictionary
	NSNumber* edition = [NSNumber numberWithInt:mEdition];
	NSNumber* card    = [NSNumber numberWithInt:mCurrentCard];
   
	NSDictionary* d   = [NSDictionary dictionaryWithObjectsAndKeys: edition, @"edition", card, @"currentCard", nil];
	
	// create path reference
	NSString*     fileName = [[[NSBundle mainBundle] infoDictionary] valueForKey:kApplicationIDKey];
	NSString*     path     = [[NSString alloc] initWithFormat:@"~/Library/Preferences/%@", fileName];

	// store what the deck we are currently using...
	[d writeToFile:[path stringByExpandingTildeInPath] atomically:YES];
    
    // also store the shuffled deck order
    [self writeDeckOrder];
}

@end

// EOF
