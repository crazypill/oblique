//
//  InterfaceController.h
//  Oblique Watch Extension
//
//  Created by Alex Lelievre on 8/17/18.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

#import "ObStrategies.h"

@interface InterfaceController : WKInterfaceController
@property (weak) IBOutlet WKInterfaceGroup* cardGroup;
@property (weak) IBOutlet WKInterfaceLabel* cardText;

- (IBAction)handleTapGesture:(WKGestureRecognizer*)gestureRecognizer;
- (IBAction)handleSwipeGesture:(WKGestureRecognizer*)gestureRecognizer;
- (ObStrategies*)getDeck;

@end
