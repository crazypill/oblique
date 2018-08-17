
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

19sep07	alx	Created

*/



///////////////////////////////////////////////////////////////////////////////
//
// Defines
//
///////////////////////////////////////////////////////////////////////////////

#ifdef DEBUG
  #define DLog(...)                          LogMsg( __VA_ARGS__ )
  #define trace(...)                         printf( __VA_ARGS__ )
  #define nstrace(...)                       printf( "%s", [[NSString stringWithFormat:__VA_ARGS__] UTF8String] )
  #define traceFrame( comment, a )           (printf( comment #a ".frame: (%0.2f, %0.2f) (%0.2f, %0.2f)\n", a.frame.origin.x, a.frame.origin.y, a.frame.size.width, a.frame.size.height ))
  #define traceFrameCenter( comment, a )     (printf( comment #a ".frame: (%0.2f, %0.2f) (%0.2f, %0.2f) center: [%0.2f, %0.2f]\n", a.frame.origin.x, a.frame.origin.y, a.frame.size.width, a.frame.size.height, a.center.x, a.center.y ))
  #define traceFrameCenterObj( comment, a )  (printf( comment #a ".frame: (%0.2f, %0.2f) (%0.2f, %0.2f) center: [%0.2f, %0.2f] class: %s\n", a.frame.origin.x, a.frame.origin.y, a.frame.size.width, a.frame.size.height, a.center.x, a.center.y, [[[a class] description] UTF8String] ))
  #define traceBounds( comment, a )          (printf( comment #a ".bounds: (%0.2f, %0.2f) (%0.2f, %0.2f)\n", a.bounds.origin.x, a.bounds.origin.y, a.bounds.size.width, a.bounds.size.height ))
  #define traceBoundsCenter( comment, a )    (printf( comment #a ".bounds: (%0.2f, %0.2f) (%0.2f, %0.2f) center: [%0.2f, %0.2f]\n", a.bounds.origin.x, a.bounds.origin.y, a.bounds.size.width, a.bounds.size.height, a.center.x, a.center.y ))
  #define traceBoundsCenterObj( comment, a ) (printf( comment #a ".bounds: (%0.2f, %0.2f) (%0.2f, %0.2f) center: [%0.2f, %0.2f] class: %s\n", a.bounds.origin.x, a.bounds.origin.y, a.bounds.size.width, a.bounds.size.height, a.center.x, a.center.y, [[[a class] description] UTF8String] ))
  #define traceCenter( comment, a )          (printf( comment #a ".center: (%0.2f, %0.2f)\n", a.center.x, a.center.y ))
#else
  #define DLog(...)
  #define trace(...)
  #define nstrace(...)
  #define traceFrame( comment, a ) 
  #define traceFrameCenter( comment, a ) 
  #define traceFrameCenterObj( comment, a )
  #define traceBounds( comment, a )
  #define traceBoundsCenter( comment, a )
  #define traceBoundsCenterObj( comment, a )
  #define traceCenter( comment, a )
#endif

#ifdef __cplusplus
extern "C" {
#endif

void LogMsg( const char* const s, ... );
#ifdef __cplusplus
}
#endif


#define kApplicationIcon         @"icon.png"
#define kApplicationAboutIcon    @"about.png"
#define kApplicationIDKey        @"CFBundleIdentifier"
#define kApplicationVersionKey   @"CFBundleShortVersionString"

//#define kCardFrontImageLandscape @"Default_l.png"
#define kCardFrontImage          @"Default.png"
//#define kCardBackImageLandscape  @"back_l.png"
#define kCardBackImage           @"back.png"
//#define kCardPrefsImageLandscape @"prefs_l.png"
#define kCardPrefsImage          @"prefs.png"
#define kCardFrontPrefsButton    @"info.png"
#define kCardPrefsDoneButton     @"done_pressed.png"
#define kCardPrefsDoneButtonUp   @"done.png"

#define gApp  ((ObliqueAppDelegate*)[[UIApplication sharedApplication] delegate])
#define gRoot [(ObliqueAppDelegate*)[[UIApplication sharedApplication] delegate] getRoot]

#import <UIKit/UIKit.h>

// EOF
