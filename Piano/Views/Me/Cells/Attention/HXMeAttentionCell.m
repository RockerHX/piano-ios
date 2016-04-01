//
//  HXMeAttentionCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeAttentionCell.h"
#import "UIImageView+WebCache.h"


@implementation HXMeAttentionCell

#pragma mark - Public Methods
- (void)updateCellWithAttention:(HXAttentionModel *)attention {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:attention.avatarUrl]];
    _nickNameLabel.text = attention.nickName;
    _livePromptView.hidden = !attention.live;
}

@end
