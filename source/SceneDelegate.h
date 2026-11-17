//
//  SceneDelegate.h
//  oblique
//
//  Created by Alex Lelievre on 14nov26.
//  Copyright © 2020-2026 Alex Lelievre. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SceneDelegate : NSObject <UIWindowSceneDelegate>
@property (nullable, nonatomic, strong) UIWindow* window;

+ (UIWindowScene* _Nullable)getActiveScene;
+ (CGRect)getWindowRect;
@end

