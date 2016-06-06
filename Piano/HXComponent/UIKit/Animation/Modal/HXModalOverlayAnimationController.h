//
//  HXModalOverlayAnimationController.h
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSTimeInterval HXModalTransitionDuration = 0.4f;


typedef NS_ENUM(NSUInteger, HXModalDirection) {
    HXModalDirectionDefault = 0,
    HXModalDirectionTop     = 1,
    HXModalDirectionBottom  = HXModalDirectionDefault,
    HXModalDirectionLeft    = 2,
    HXModalDirectionRight   = 3,
};


@interface HXModalOverlayAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) HXModalDirection  direction;
@property (nonatomic, assign, readonly)   NSTimeInterval  transitionDuration;

+ (instancetype)instance;
+ (instancetype)instanceWithDirection:(HXModalDirection)direction;
+ (instancetype)instanceWithDirection:(HXModalDirection)direction transitionDuration:(NSTimeInterval)transitionDuration;

@end
