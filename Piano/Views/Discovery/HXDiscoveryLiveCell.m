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

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [super loadConfigure];
}

- (void)viewConfigure {
    [super viewConfigure];
    
    _changCoverButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _changCoverButton.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _changCoverButton.layer.shadowOpacity = 1.0f;
}

#pragma mark - Event Response
- (IBAction)startLiveButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(liveCell:takeAction:)]) {
        [_delegate liveCell:self takeAction:HXDiscoveryLiveCellActionStartLive];
    }
}

- (IBAction)changCoverButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(liveCell:takeAction:)]) {
        [_delegate liveCell:self takeAction:HXDiscoveryLiveCellActionChangeCover];
    }
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXDiscoveryModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
}

@end
