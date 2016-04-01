//
//  HXMeHeaderCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeHeaderCell.h"
#import "UIImageView+WebCache.h"


@implementation HXMeHeaderCell

#pragma mark - Public Methods
- (void)updateCellWithProfileModel:(HXProfileModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _summaryLabel.text = model.summary;
}

@end
