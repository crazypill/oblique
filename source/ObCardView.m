
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

29sep07	alx	Slight cleanup
18sep07	alx	Created

*/


///////////////////////////////////////////////////////////////////////////////
//
// Includes
//
///////////////////////////////////////////////////////////////////////////////

#import "ObCardView.h"
#import "ObliqueAppDelegate.h"


///////////////////////////////////////////////////////////////////////////////
//
// Constants
//
///////////////////////////////////////////////////////////////////////////////

const float  kCardTitleFontSize	   = 22.0f;
const float  kCardTextFontSize	   = 15.0f;
const float  kCardMiscFontSize	   = 14.0f;

const float  kCardTextTop		   = 180; //175;
const float  kCardTextHeight	   = (19 + 4) * 3;		// three lines + slop
const float  kCardSubTextYOffset   = 30;
const float  kCardSlop             = 16;


#define kTitleString    @"OBLIQUE STRATEGIES"
#define kTitleSubString @"Brian Eno / Peter Schmidt"

char* const firstUse  = "Thank you for using this iPhone native version of Oblique Strategies. You can use the preferences panel (accessible by clicking the 'i' on the frontside) to change the decks [to the four available Editions].";

#define kTitleFont [UIFont fontWithName:@"Georgia-Bold" size:kCardTitleFontSize]
#define kTextFont  [UIFont fontWithName:@"Verdana" size:kCardTextFontSize]
#define kMiscFont  [UIFont fontWithName:@"Helvetica" size:kCardMiscFontSize]


///////////////////////////////////////////////////////////////////////////////
//
// ObCardView Implementation
//
///////////////////////////////////////////////////////////////////////////////

@implementation ObCardView

- (id)initWithFrame:(CGRect)frame
{
	// !!@ what's the deal with these bogus empty frames? and it still works ???
//	trace( "CardView initWithFrame: %d,%d (%d, %d)", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height );
	self = [super initWithFrame:frame];
    
//    nstrace( [[UIFont familyNames] description] );
//    nstrace( [[UIFont fontNamesForFamilyName:@"Georgia"] description] );
    

	mFlipped = NO;
	
	[self setOpaque:NO];

	mText = [[UILabel alloc] initWithFrame:frame];
	mText.textAlignment = NSTextAlignmentCenter;
    mText.lineBreakMode = UILineBreakModeWordWrap;
    mText.numberOfLines = 5;

    mSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];  
    mSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;     
    [self addGestureRecognizer:mSwipeGesture];
    
    mTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:mTapGesture];

    return self;
}


///////////////////////////////////////////////////////////////////////////////

- (void)drawRect:(CGRect)rect;
{
	CGContextRef ctx = UIGraphicsGetCurrentContext();

    [[UIImage imageNamed:mFlipped ? kCardBackImage : kCardFrontImage] drawAtPoint:CGPointMake( 0, 0 )];//-[UIHardware statusBarHeight] )];

    // draw everything sideways... figure out which way they are holding the device !!@
	CGContextSaveGState( ctx );
    CGContextTranslateCTM( ctx, self.bounds.size.width / 2, self.bounds.size.height / 2 );
    CGContextRotateCTM( ctx, M_PI / 2 );
    CGContextTranslateCTM( ctx, -self.bounds.size.width / 2, -self.bounds.size.height / 2 );
    
	if( mFlipped )
	{
        // this is where we grab the random card off the deck.  We _depend_ on the fact that the display routines are properly implemented and come here once
        mText.text = [[gApp getDeck] getRandomCard];
        mText.font = kTextFont;
        mText.textColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
        
        // center text in card
        CGSize textSize = [mText.text sizeWithFont:kTextFont constrainedToSize:self.bounds.size lineBreakMode:mText.lineBreakMode];
        
        [mText drawTextInRect:CGRectMake( 0, (self.bounds.size.height - textSize.height) * 0.5f , [self bounds].size.width, textSize.height )];
	}
	else
	{
		mText.textColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
		mText.text = kTitleString;
		mText.font = kTitleFont;
		[mText drawTextInRect:CGRectMake( kCardSlop, kCardTextTop, [self bounds].size.width - (kCardSlop * 2), kCardTextHeight )];
		
		// put text underneath
		mText.text = kTitleSubString;
		mText.font = kMiscFont;
		[mText drawTextInRect:CGRectMake( kCardSlop, kCardTextTop + kCardSubTextYOffset, [self bounds].size.width - (kCardSlop * 2), 60 )];
	}

	CGContextRestoreGState( ctx );
}

///////////////////////////////////////////////////////////////////////////////

- (bool)flipped
{
	return mFlipped;
}

- (IBAction)toggleView 
{	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationTransition:( mFlipped ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft ) forView:self cache:YES];
	
    mFlipped = !mFlipped;
    [self setNeedsDisplay];

	[UIView commitAnimations];
}


- (void)handleTap:(UITapGestureRecognizer*)sender
{
    if( sender.state == UIGestureRecognizerStateEnded )
    {
        // handling code
        [self toggleView];
    }
}


- (void)handleSwipe:(UISwipeGestureRecognizer*)sender
{
    if( !mFlipped )
        return;
        
    if( sender.state == UIGestureRecognizerStateEnded )
    {
        // handling code
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5f];
//        [UIView setAnimationTransition:( mFlipped ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft ) forView:self cache:YES];
        [self setNeedsDisplay];
        [UIView commitAnimations];
    }
}


/*
// !!@ for debugging
- (BOOL)respondsToSelector:(SEL)selector
{
  trace( @"ObCardView:respondsToSelector: %s", selector );
  return [super respondsToSelector:selector];
}

*/

@end


// EOF
