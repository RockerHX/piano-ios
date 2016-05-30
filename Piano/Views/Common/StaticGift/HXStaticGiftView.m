//
//  HXStaticGiftView.m
//  Piano
//
//  Created by miaios on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXStaticGiftView.h"
#import "HXXib.h"
#import "UIImageView+WebCache.h"
#import "YYImage.h"


@implementation HXStaticGiftView {
    dispatch_queue_t _queue;
    dispatch_semaphore_t _semaphore;
    
    BOOL _exchenge;
}

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _queue = dispatch_queue_create("com.gift.static_animation", DISPATCH_QUEUE_CONCURRENT);
    _semaphore = dispatch_semaphore_create(2);
}

- (void)viewConfigure {
    _topItemView.hidden = YES;
    _bottomItemView.hidden = YES;
}

#pragma mark - Public Methods
- (void)animationWithGift:(HXGiftModel *)gift {
    if (gift.type == HXGiftTypeStatic) {
        dispatch_async(_queue, ^{
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (_bottomItemView.hidden) {
                    _bottomItemView.hidden = NO;
                    _bottomItemView.alpha = 1.0f;
                    [_bottomItemView showGift:gift completed:^{
                        [UIView animateWithDuration:0.5f delay:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                            _bottomItemView.alpha = 0.0f;
                        } completion:^(BOOL finished) {
                            _bottomItemView.hidden = YES;
                            dispatch_semaphore_signal(_semaphore);
                        }];
                    }];
                } else if (_topItemView.hidden) {
                    _topItemView.hidden = NO;
                    _topItemView.alpha = 1.0f;
                    [_topItemView showGift:gift completed:^{
                        [UIView animateWithDuration:0.5f delay:1.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
                            _topItemView.alpha = 0.0f;
                        } completion:^(BOOL finished) {
                            _topItemView.hidden = YES;
                            dispatch_semaphore_signal(_semaphore);
                        }];
                    }];
                }
            });
        });
    }
}

@end
