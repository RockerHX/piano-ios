//
//  HXDiscoveryNormalCell.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryNormalCell.h"
#import "UIImageView+WebCache.h"


@implementation HXDiscoveryNormalCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [_anchorContainer addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)]];
}

#pragma mark - Event Reponse
- (void)tapGesture {
    if (_delegate && [_delegate respondsToSelector:@selector(discoveryNormalCellAnchorContainerTaped:)]) {
        [_delegate discoveryNormalCellAnchorContainerTaped:self];
    }
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXDiscoveryModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _promptLabel.text = model.prompt;
    
    _titleLabel.text = model.title;
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
}

@end
