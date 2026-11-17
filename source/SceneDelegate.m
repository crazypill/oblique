//
//  SceneDelegate.m
//  oblique
//
//  Created by Alex Lelievre on 14nov26.
//  Copyright © 2020-2026 Alex Lelievre. All rights reserved.
//

#import "SceneDelegate.h"
#import "RootViewController.h"
#import "MainViewController.h"
#import "ObliqueAppDelegate.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


+ (UIWindowScene*)getActiveScene
{
    UIWindowScene* activeWindowScene = nil;
        
    // Get all connected scenes
    NSSet* scenes = [[UIApplication sharedApplication] connectedScenes];
    
    for( UIScene* scene in scenes )
    {
        // Check if the scene is a UIWindowScene and is currently active in the foreground
        if( scene && [scene isKindOfClass:[UIWindowScene class]] && scene.activationState == UISceneActivationStateForegroundActive )
        {
            activeWindowScene = (UIWindowScene*)scene;
            break;
        }
    }
    
    // Fallback to the first window scene if no active foreground scene is found
    if( !activeWindowScene )
    {
        for( UIScene* scene in scenes )
        {
            if( scene && [scene isKindOfClass:[UIWindowScene class]] )
            {
                activeWindowScene = (UIWindowScene*)scene;
                break;
            }
        }
    }
    return activeWindowScene;
}


+ (CGRect)getWindowRect
{
    UIWindow* window = SceneDelegate.getActiveScene.windows.firstObject;
    return window.bounds;
}


- (void)scene:(UIScene*)scene willConnectToSession:(UISceneSession*)session options:(UISceneConnectionOptions*)connectionOptions
{
//    trace( "scene:willConnectToSession:\n" );

    if( scene && [scene isKindOfClass:[UIWindowScene class]] )
    {
        UIWindowScene* windowScene = (UIWindowScene*)scene;
        windowScene.sizeRestrictions.minimumSize = CGSizeMake( 320.0f, 480.0f );  // these are the original iPhone's screen dimensions
    }
}


- (void)sceneDidBecomeActive:(UIScene*)scene
{
//    trace( "sceneDidBecomeActive\n" );
}

- (void)sceneWillResignActive:(UIScene*)scene
{
//    trace( "sceneWillResignActive\n" );
    [[gApp getDeck] persistDeck];
}


- (void)sceneDidEnterBackground:(UIScene*)scene
{
//    trace( "sceneDidEnterBackground\n" );
}

- (void)sceneWillEnterForeground:(UIScene*)scene
{
//    trace( "sceneWillEnterForeground\n" );
}

@end
