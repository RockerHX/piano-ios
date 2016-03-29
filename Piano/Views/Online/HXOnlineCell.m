//
//  HXOnlineCell.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineCell.h"
#import "UIImageView+WebCache.h"


@implementation HXOnlineCell

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXOnlineModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _attendeCountLabel.text = @(model.onlineCount).stringValue;
    
    _titleLabel.text = model.title;
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
}

@end
