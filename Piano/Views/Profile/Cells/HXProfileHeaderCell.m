//
//  HXProfileHeaderCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileHeaderCell.h"
#import "HXProfileModel.h"
#import "UIImageView+WebCache.h"


@implementation HXProfileHeaderCell

#pragma mark - Public Methods
- (void)updateCellWithProfileModel:(HXProfileModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _summaryLabel.text = model.summary;
    _fansCountLabel.text = @(model.fansCount).stringValue;
    _followCountLabel.text = @(model.followCount).stringValue;
}

@end
