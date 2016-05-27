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
}

- (void)viewConfigure {
    self.hidden = YES;
}

#pragma mark - Public Methods
- (void)animationWithGift:(HXGiftModel *)gift {
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:gift.avatarUrl]];
    _nickNameLabel.text = gift.nickName;
    _promptLabel.text = gift.prompt;
    
    if (gift.type == HXGiftTypeDynamic) {
        dispatch_async(_queue, ^{
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.hidden = NO;
//                NSLog(@"-------------------");
//                NSLog(@"Gift View Hidden State:%@", self.hidden ? @"YES" : @"NO");
                YYImage *image = [YYImage imageWithData:gift.animationData];
                _animationView.image = image;
//                NSLog(@"-------------------");
//                NSLog(@"Anmation Start");
            });
//            NSLog(@"-------------------");
//            NSLog(@"Play Time:%@", @(gift.playTime).stringValue);
            sleep(gift.playTime);
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.hidden = YES;
                _animationView.image = nil;
//                NSLog(@"-------------------");
//                NSLog(@"Anmation End");
            });
        });
    }
}

@end
