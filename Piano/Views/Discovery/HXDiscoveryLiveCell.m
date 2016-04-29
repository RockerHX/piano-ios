//
//  HXDiscoveryLiveCell.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryLiveCell.h"
#import "UIImageView+WebCache.h"


@implementation HXDiscoveryLiveCell

#pragma mark - Event Response
- (IBAction)startLiveButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(liveCellStartLive:)]) {
        [_delegate liveCellStartLive:self];
    }
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXDiscoveryModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
}

@end
