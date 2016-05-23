//
//  HXLiveRewardTopCell.m
//  Piano
//
//  Created by miaios on 16/5/20.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveRewardTopCell.h"
#import "UIImageView+WebCache.h"


@implementation HXLiveRewardTopCell

#pragma mark - Public Methods
- (void)updateWithTop:(HXLiveRewardTopModel *)top {
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:top.avatarUrl]];
    _indexLabel.text = @(top.index).stringValue;
    _nickNameLabel.text = top.nickName;
    _coinTotalLabel.text = @(top.coinTotal).stringValue;
}

@end
