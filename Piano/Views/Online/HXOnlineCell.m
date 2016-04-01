//
//  HXOnlineCell.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineCell.h"
#import "UIImageView+WebCache.h"


@implementation HXOnlineCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [_anchorContainer addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)]];
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXOnlineModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _attendeCountLabel.text = @(model.onlineCount).stringValue;
    
    _titleLabel.text = model.title;
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
}

#pragma mark - Event Reponse
- (void)tapGesture {
    if (_delegate && [_delegate respondsToSelector:@selector(onlineCellAnchorContainerTaped:)]) {
        [_delegate onlineCellAnchorContainerTaped:self];
    }
}

@end
