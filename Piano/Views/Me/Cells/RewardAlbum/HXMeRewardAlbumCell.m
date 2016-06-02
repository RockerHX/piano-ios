//
//  HXMeRewardAlbumCell.m
//  Piano
//
//  Created by miaios on 16/6/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeRewardAlbumCell.h"
#import "UIImageView+WebCache.h"


@implementation HXMeRewardAlbumCell

#pragma mark - Public Methods
- (void)updateCellWithAlbum:(HXAlbumModel *)album {
    [_cover sd_setImageWithURL:[NSURL URLWithString:album.coverUrl]];
    _titleLabel.text = album.title;
}

@end
