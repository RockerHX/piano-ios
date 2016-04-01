//
//  HXProfileAlbumCell.m
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileAlbumCell.h"
#import "UIImageView+WebCache.h"


@implementation HXProfileAlbumCell

#pragma mark - Public Methods
- (void)updateCellWithAlbum:(HXAlbumModel *)album {
    [_cover sd_setImageWithURL:[NSURL URLWithString:album.coverUrl]];
    _titleLabel.text = album.title;
}

@end
