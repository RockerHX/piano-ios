//
//  HXDiscoveryNormalCell.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryNormalCell.h"
#import "UIImageView+WebCache.h"
#import "HexColors.h"


@implementation HXDiscoveryNormalCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXDiscoveryModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
    
    _nickNameContainer.backgroundColor = [UIColor hx_colorWithHexRGBAString:model.coverColor];
    _nickNameLabel.text = model.nickName;
}

@end
