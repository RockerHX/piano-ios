//
//  HXDiscoveryShowCell.m
//  Piano
//
//  Created by miaios on 16/4/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryShowCell.h"
#import "UIImageView+WebCache.h"


@implementation HXDiscoveryShowCell

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
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXDiscoveryModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
    _countLabel.text = @(model.onlineCount).stringValue;
    _nickNameLabel.text = model.nickName;
    _titleLabel.text = model.title;
}

@end
