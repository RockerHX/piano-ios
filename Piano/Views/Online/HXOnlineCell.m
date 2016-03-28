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

#pragma mark - Public Methods
- (void)displayCellWithModel:(HXOnlineModel *)model {
//    [_publisherAvatar sd_setImageWithURL:[NSURL URLWithString:model.]];
//    [_previewCover sd_setImageWithURL:[NSURL URLWithString:model.]];
    
//    _publisherNameLabel.text = model.nickName;
//    _publishInfoLabel.text = model.;
    _titleLabel.text = model.title;
//    _favoriteCountLabel.text = @(model.viewCount).stringValue;
    _attendeCountLabel.text = @(model.onlineCount).stringValue;
}

@end
