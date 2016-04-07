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
    [_slider setThumbImage:[UIImage imageNamed:@"AD-SliderThumbIcon"] forState:UIControlStateNormal];
}

#pragma mark - Event Response
- (IBAction)playButtonPressed:(UIButton *)button {
    button.selected = !button.selected;
    if (_delegate && [_delegate respondsToSelector:@selector(controlCell:takeAction:)]) {
        [_delegate controlCell:self takeAction:(button.selected ? HXAlbumsControlCellActionPlay : HXAlbumsControlCellActionPause)];
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

- (IBAction)valueChange:(UISlider *)slider {
	NSLog(@"slider value : %.2f",[slider value]);

	if (_delegate && [_delegate respondsToSelector:@selector(controlCell:seekToPosition:)]) {
		[_delegate controlCell:self seekToPosition:[slider value]];
	}
}
#pragma mark - Public Methods
- (void)updateCellWithAlbum:(HXAlbumModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
}

@end
