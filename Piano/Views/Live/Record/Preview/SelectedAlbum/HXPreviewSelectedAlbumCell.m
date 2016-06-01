//
//  HXPreviewSelectedAlbumCell.m
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPreviewSelectedAlbumCell.h"
#import "UIImageView+WebCache.h"


@implementation HXPreviewSelectedAlbumCell

#pragma mark - Public Methods
- (void)updateWithAlbum:(HXAlbumModel *)album {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:album.coverUrl]];
    _selectedMaskView.hidden = !album.selected;
    _titleLabel.text = album.title;
}

@end
