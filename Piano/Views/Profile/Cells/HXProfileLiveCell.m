//
//  HXProfileLiveCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileLiveCell.h"
#import "HXProfileModel.h"
#import "UIImageView+WebCache.h"


@implementation HXProfileLiveCell

#pragma mark - Public Methods
- (void)updateCellWithProfileModel:(HXProfileModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.liveCoverUrl]];
    _viewCountLabel.text = @(model.liveViewCount).stringValue;
    _nickNameLabel.text = model.nickName;
    _titleLabel.text = [NSString stringWithFormat:@"主题：%@", model.liveTitle];
}

@end
