//
//  InterfaceController.m
//  Oblique Watch Extension
//
//  Created by Alex Lelievre on 8/17/18.
//

#import "InterfaceController.h"


@interface InterfaceController ()
{
    ObStrategies* mStrategies;
}
@end



@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    mStrategies = [[ObStrategies alloc] init];
}

- (ObStrategies*)getDeck
{
    return mStrategies;
}


- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}


- (IBAction)handleTapGesture:(WKGestureRecognizer*)gestureRecognizer
{
    self.cardText.text = [[self getDeck] getRandomCard];
}


- (IBAction)handleSwipeGesture:(WKGestureRecognizer*)gestureRecognizer
{
    self.cardText.text = [[self getDeck] getRandomCard];
}



@end



