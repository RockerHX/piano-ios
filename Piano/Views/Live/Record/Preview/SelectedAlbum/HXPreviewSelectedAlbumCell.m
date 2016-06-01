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

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    self.layer.borderWidth = 0.5f;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

#pragma mark - Public Methods
- (void)updateWithAlbum:(HXAlbumModel *)album {
    [_coverView sd_setImageWithURL:[NSURL URLWithString:album.coverUrl]];
    _selectedMaskView.hidden = !album.selected;
    _titleLabel.text = album.title;
}

@end
