//
//  HXModalTransitionDelegate.m
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXModalTransitionDelegate.h"


@implementation HXModalTransitionDelegate {
    HXModalOverlayAnimationController *_animationController;
}

#pragma mark - Public Methods
+ (instancetype)instance {
    return [HXModalTransitionDelegate instanceWithDirection:HXModalDirectionDefault];
}

+ (instancetype)instanceWithDirection:(HXModalDirection)direction {
    return [HXModalTransitionDelegate instanceWithDirection:direction transitionDuration:HXModalTransitionDuration];
}

+ (instancetype)instanceWithDirection:(HXModalDirection)direction transitionDuration:(NSTimeInterval)transitionDuration {
    return [[HXModalTransitionDelegate alloc] initWithDirection:direction transitionDuration:transitionDuration];
}

#pragma mark - Initialize Methods
- (instancetype)initWithDirection:(HXModalDirection)direction transitionDuration:(NSTimeInterval)transitionDuration {
    self = [super init];
    if (self) {
        _direction = direction;
        _transitionDuration = transitionDuration;
        _animationController = [HXModalOverlayAnimationController instanceWithDirection:direction transitionDuration:transitionDuration];
        
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _transitionDuration = HXModalTransitionDuration;
        _animationController = [HXModalOverlayAnimationController new];
    }
    return self;
}

#pragma mark - UIViewControllerTransitioningDelegate Methods
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return _animationController;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return _animationController;
}

@end
