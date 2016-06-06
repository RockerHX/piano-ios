//
//  HXModalOverlayAnimationController.m
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXModalOverlayAnimationController.h"


@implementation HXModalOverlayAnimationController

#pragma mark - Public Methods
+ (instancetype)instance {
    return [HXModalOverlayAnimationController instanceWithDirection:HXModalDirectionDefault];
}

+ (instancetype)instanceWithDirection:(HXModalDirection)direction {
    return [HXModalOverlayAnimationController instanceWithDirection:direction transitionDuration:HXModalTransitionDuration];
}

+ (instancetype)instanceWithDirection:(HXModalDirection)direction transitionDuration:(NSTimeInterval)transitionDuration {
    return [[HXModalOverlayAnimationController alloc] initWithDirection:direction transitionDuration:transitionDuration];
}

#pragma mark - Initialize Methods
- (instancetype)initWithDirection:(HXModalDirection)direction transitionDuration:(NSTimeInterval)transitionDuration {
    self = [super init];
    if (self) {
        _direction = direction;
        _transitionDuration = transitionDuration;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _transitionDuration = HXModalTransitionDuration;
    }
    return self;
}

#pragma mark - Private Methods
- (CGPoint)startCenterWithView:(UIView *)view {
    CGPoint center;
    switch (_direction) {
        case HXModalDirectionTop: {
            center = CGPointMake(view.center.x, view.frame.size.height * -1.5f);
            break;
        }
        case HXModalDirectionLeft: {
            center = CGPointMake(view.frame.size.width * -1.5f, view.center.y);
            break;
        }
        case HXModalDirectionRight: {
            center = CGPointMake(view.frame.size.width * 1.5f, view.center.y);
            break;
        }
        default: {
            center = CGPointMake(view.center.x, view.frame.size.height * 1.5f);
            break;
        }
    }
    return center;
}

- (CGPoint)endCenterWithView:(UIView *)view {
    CGPoint center;
    switch (_direction) {
        case HXModalDirectionLeft:
        case HXModalDirectionRight: {
            center = CGPointMake(fabs(view.center.x / 3), view.center.y);
            break;
        }
        default: {
            center = CGPointMake(view.center.x, fabs(view.center.y / 3));
            break;
        }
    }
    return center;
}


#pragma mark - UIViewControllerAnimatedTransitioning Methods
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return _transitionDuration;
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
                
                toView.center = [self startCenterWithView:toView];
                [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                    toView.center = [self endCenterWithView:toView];
                } completion:^(BOOL finished) {
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!isCancelled];
                }];
            }
            
            if ([fromViewController isBeingDismissed]) {
                [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
                    fromView.center = [self startCenterWithView:fromView];
                } completion:^(BOOL finished) {
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    [transitionContext completeTransition:!isCancelled];
                }];
            }
        }
    }
}


@end
