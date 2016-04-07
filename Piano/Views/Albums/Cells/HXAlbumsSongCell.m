//
//  HXAlbumsSongCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsSongCell.h"
#import "HXSongModel.h"


@implementation HXAlbumsSongCell

#pragma mark - Public Methods
- (void)updateCellWithSong:(HXSongModel *)song index:(NSInteger)index {
    _stateIcon.hidden = !song.play;
    _indexLabel.hidden = song.play;
    _indexLabel.text = @(index + 1).stringValue;
    _nameLabel.text = song.title;
    _durationLabel.text = song.durationPrompt;
}

@end
