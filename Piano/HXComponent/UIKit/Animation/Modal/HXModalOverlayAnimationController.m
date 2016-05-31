//
//  HXModalOverlayAnimationController.m
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXModalOverlayAnimationController.h"


@implementation HXModalOverlayAnimationController

#pragma mark - UIViewControllerAnimatedTransitioning Methods
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.4f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (fromViewController && toViewController) {
        UIView *containerView = [transitionContext containerView];
        if (containerView) {
            UIView *fromView = fromViewController.view;
            UIView *toView = toViewController.view;
            NSTimeInterval duration = [self transitionDuration:transitionContext];
            
            if ([toViewController isBeingPresented]) {
                [containerView addSubview:toView];
                
                toView.center = CGPointMake(toView.center.x, toView.frame.size.height * 1.5f);
                [UIView animateWithDuration:duration animations:^{
                    toView.center = CGPointMake(toView.center.x, toView.center.y / 3);
                } completion:^(BOOL finished) {
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!isCancelled];
                }];
            }
            
            if ([fromViewController isBeingDismissed]) {
                [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    fromView.center = CGPointMake(fromView.center.x, fromView.frame.size.height * 1.5f);
                } completion:^(BOOL finished) {
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!isCancelled];
                }];
            }
        }
    }
}


@end
