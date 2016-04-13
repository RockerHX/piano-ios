//
//  UIViewController+LoginAction.m
//  Piano
//
//  Created by miaios on 16/4/13.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+LoginAction.h"
#import "HXLoginViewController.h"


@implementation UIViewController (LoginAction)

#pragma mark - Public Methods
- (HXLoginViewController *)showLoginSence {
    UINavigationController *loginNavigationController = [HXLoginViewController navigationControllerInstance];
    HXLoginViewController *loginViewController = loginNavigationController.viewControllers.firstObject;
    
    [self transitionAnimationWithDuration:0.3f type:kCATransitionMoveIn subtype:kCATransitionFromRight transiteCode:^{
        [self presentViewController:loginNavigationController animated:NO completion:nil];
    }];
    return loginViewController;
}

- (void)dismissLoginSence {
    if ([self isKindOfClass:[HXLoginViewController class]]) {
        [self transitionAnimationWithDuration:0.3f type:kCATransitionReveal subtype:kCATransitionFromLeft transiteCode:^{
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

- (void)transitionAnimationWithDuration:(CFTimeInterval)duration type:(NSString *)type subtype:(NSString *)subtype transiteCode:(void(^)(void))transiteCode {
    if (transiteCode) {
        [CATransaction begin];
        
        CATransition *transition = [CATransition animation];
        transition.duration = duration;
        transition.type = type;
        transition.subtype = subtype;
        transition.fillMode = kCAFillModeForwards;
        
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:kCATransition];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [CATransaction setCompletionBlock: ^ {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            });
        }];
        
        transiteCode();
        
        [CATransaction commit];
    }
}

@end
