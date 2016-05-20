//
//  HXLiveJoinKingCell.m
//  Piano
//
//  Created by miaios on 16/5/20.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveJoinKingCell.h"
#import "UIImageView+WebCache.h"


@implementation HXLiveJoinKingCell

#pragma mark - Public Methods
- (void)updateWithKing:(HXLiveJoinKingModel *)king {
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:king.avatarUrl]];
    _indexLabel.text = @(king.index).stringValue;
    _nickNameLabel.text = king.nickName;
    _coinTotalLabel.text = @(king.coinTotal).stringValue;
}

@end
