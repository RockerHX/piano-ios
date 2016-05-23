//
//  HXLiveGiftItemCell.m
//  Piano
//
//  Created by miaios on 16/5/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveGiftItemCell.h"
#import "UIImageView+WebCache.h"


@implementation HXLiveGiftItemCell

#pragma mark - Public Methods
- (void)updateWithGift:(HXGiftModel *)gift {
//    [_giftLogo sd_setImageWithURL:[NSURL URLWithString:gift.]];
    _bgView.image = [UIImage imageNamed:(gift.selected ? @"LG-GiftSeletedBG" : nil)];
    _coinCountLabel.text = @(gift.mcoin).stringValue;
}

@end
