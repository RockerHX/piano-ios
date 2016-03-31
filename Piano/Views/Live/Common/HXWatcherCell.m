//
//  HXWatcherCell.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherCell.h"
#import "UIImageView+WebCache.h"


@implementation HXWatcherCell

#pragma mark - Public Methods
- (void)updateWithWatcher:(HXWatcherModel *)watcher {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:watcher.avatarUrl]];
}

@end
