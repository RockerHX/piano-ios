//
//  HXMeHeaderCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeHeaderCell.h"
#import "UIImageView+WebCache.h"


@implementation HXMeHeaderCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [_avatar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTaped)]];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (void)avatarTaped {
    if (_delegate && [_delegate respondsToSelector:@selector(headerCell:takeAction:)]) {
        [_delegate headerCell:self takeAction:HXMeHeaderCellActionAvatarTaped];
    }
}

#pragma mark - Public Methods
- (void)updateCellWithProfileModel:(HXProfileModel *)model {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _summaryLabel.text = model.summary;
}

@end
