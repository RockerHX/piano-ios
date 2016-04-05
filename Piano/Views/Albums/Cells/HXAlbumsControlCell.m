//
//  HXAlbumsControlCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsControlCell.h"
#import "UIImageView+WebCache.h"
#import "HXAlbumModel.h"


@implementation HXAlbumsControlCell

#pragma mark - Event Response
- (IBAction)playButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlCell:takeAction:)]) {
        [_delegate controlCell:self takeAction:HXAlbumsControlCellActionPlay];
    }
}

- (IBAction)previousButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlCell:takeAction:)]) {
        [_delegate controlCell:self takeAction:HXAlbumsControlCellActionPrevious];
    }
}

- (IBAction)nextButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlCell:takeAction:)]) {
        [_delegate controlCell:self takeAction:HXAlbumsControlCellActionNext];
    }
}

#pragma mark - Public Methods
- (void)updateCellWithAlbum:(HXAlbumModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
    
}

@end
