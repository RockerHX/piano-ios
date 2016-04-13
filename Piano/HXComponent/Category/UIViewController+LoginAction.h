//
//  UIViewController+LoginAction.h
//  Piano
//
//  Created by miaios on 16/4/13.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+LoginAction.h"


@class HXLoginViewController;


@interface UIViewController (LoginAction)

- (HXLoginViewController *)showLoginSence;
- (void)dismissLoginSence;
- (void)transitionAnimationWithDuration:(CFTimeInterval)duration type:(NSString *)type subtype:(NSString *)subtype transiteCode:(void(^)(void))transiteCode;

@end
