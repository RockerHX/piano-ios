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

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

#pragma mark - Public Methods
- (void)displayWithAlbum:(HXAlbumModel *)album {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:album.coverUrl]];
    _titleLabel.text = album.title;
    _summaryLabel.text = album.summary;
}

@end
