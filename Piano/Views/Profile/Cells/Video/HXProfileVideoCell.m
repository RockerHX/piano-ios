//
//  HXProfileVideoCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileVideoCell.h"
#import "UIImageView+WebCache.h"


@implementation HXProfileVideoCell

#pragma mark - Public Methods
- (void)updateCellWithVideo:(HXVideoModel *)video {
    [_cover sd_setImageWithURL:[NSURL URLWithString:video.coverUrl]];
    _titleLabel.text = video.title;
}

@end
