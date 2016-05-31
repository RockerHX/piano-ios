//
//  HXDynamicGiftView.m
//  Piano
//
//  Created by miaios on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDynamicGiftView.h"
#import "HXXib.h"
#import "UIImageView+WebCache.h"
#import "YYImage.h"


@implementation HXDynamicGiftView {
    dispatch_queue_t _queue;
    dispatch_semaphore_t _semaphore;
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
    _queue = dispatch_queue_create("com.gift.dynamic_animation", DISPATCH_QUEUE_SERIAL);
    _semaphore = dispatch_semaphore_create(1);
}

- (void)viewConfigure {
    self.hidden = YES;
}

#pragma mark - Public Methods
- (void)animationWithGift:(HXGiftModel *)gift {
    if (gift.type == HXGiftTypeDynamic) {
        [_avatarView sd_setImageWithURL:[NSURL URLWithString:gift.avatarUrl]];
        _nickNameLabel.text = gift.nickName;
        _promptLabel.text = gift.prompt;
        
        dispatch_async(_queue, ^{
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.alpha = 1.0f;
                self.hidden = NO;
                
                YYImage *image = [YYImage imageWithData:gift.animationData];
                _animationView.image = image;
                
                [UIView animateWithDuration:0.5f delay:gift.playTime options:UIViewAnimationOptionCurveEaseIn animations:^{
                    self.alpha = 0.0f;
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                    _animationView.image = nil;
                    dispatch_semaphore_signal(_semaphore);
                }];
            });
        });
    }
}

@end
