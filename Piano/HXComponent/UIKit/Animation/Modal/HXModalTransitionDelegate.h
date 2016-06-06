//
//  HXModalTransitionDelegate.h
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXModalOverlayAnimationController.h"


@interface HXModalTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, assign, readonly) HXModalDirection  direction;
@property (nonatomic, assign, readonly)   NSTimeInterval  transitionDuration;

+ (instancetype)instance;
+ (instancetype)instanceWithDirection:(HXModalDirection)direction;
+ (instancetype)instanceWithDirection:(HXModalDirection)direction transitionDuration:(NSTimeInterval)transitionDuration;

@end
