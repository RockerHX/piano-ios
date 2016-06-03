//
//  HXStaticGiftItemView.m
//  Piano
//
//  Created by miaios on 16/5/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXStaticGiftItemView.h"
#import "HXXib.h"
#import "UIImageView+WebCache.h"


@implementation HXStaticGiftItemView {
    dispatch_group_t _group;
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
    _group = dispatch_group_create();
    _queue = dispatch_queue_create("com.gift.count_animation", DISPATCH_QUEUE_SERIAL);
    _semaphore = dispatch_semaphore_create(1);
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)showGift:(HXGiftModel *)gift completed:(void(^)(void))completed {
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:gift.avatarUrl]];
    _nickNameLabel.text = gift.nickName;
    _promptLabel.text = gift.prompt;
    _giftView.image = [UIImage imageWithData:gift.animationData];
    
    for (NSInteger index = 1; index <= gift.count; index++) {
        dispatch_group_async(_group, _queue, ^{
            dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);
            dispatch_sync(dispatch_get_main_queue(), ^{
                _countLabel.text = @(index).stringValue;
                _labelContainer.transform = CGAffineTransformMakeScale(0.2f, 0.2f);
                [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    _labelContainer.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                } completion:^(BOOL finished) {
                    _labelContainer.transform = CGAffineTransformIdentity;
                    dispatch_semaphore_signal(_semaphore);
                }];
            });
        });
    }
    
    dispatch_group_notify(_group, dispatch_get_main_queue(), ^{
        if (completed) {
            completed();
        }
    });
}

@end
