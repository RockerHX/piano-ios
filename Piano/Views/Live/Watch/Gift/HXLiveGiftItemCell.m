//
//  HXLiveGiftItemCell.m
//  Piano
//
//  Created by miaios on 16/5/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveGiftItemCell.h"


@implementation HXLiveGiftItemCell

#pragma mark - Public Methods
- (void)updateWithGift:(HXGiftModel *)gift {
    _bgView.image = (gift.selected ? [UIImage imageNamed:@"LG-GiftSeletedBG"] : nil);
    _giftLogo.image = [UIImage imageWithData:gift.iconData];
    _coinCountLabel.text = gift.mcoin;
}

@end
