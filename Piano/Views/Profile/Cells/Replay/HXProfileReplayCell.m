//
//  HXProfileReplayCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileReplayCell.h"
#import "UIImageView+WebCache.h"


@implementation HXProfileReplayCell

#pragma mark - Public Methods
- (void)updateCellWithReplay:(HXReplayModel *)replay {
    [_cover sd_setImageWithURL:[NSURL URLWithString:replay.coverUrl]];
    _titleLabel.text = replay.title;
    _timeLabel.text = replay.formatTime;
}

@end
