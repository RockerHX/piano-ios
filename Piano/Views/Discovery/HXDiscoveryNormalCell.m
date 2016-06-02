//
//  HXDiscoveryNormalCell.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryNormalCell.h"
#import "UIImageView+WebCache.h"
#import "HexColors.h"


static CGFloat IconSpace = 8.0f;


@implementation HXDiscoveryNormalCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

#pragma mark - Public Methods
- (void)updateCellWithModel:(HXDiscoveryModel *)model {
    [_cover sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
    
    UIColor *coverColor = [UIColor hx_colorWithHexRGBAString:model.coverColor];
    _nickNameContainer.backgroundColor = coverColor;
    _nickNameLabel.text = model.nickName;
    
    BOOL showVideoIcon = model.showVideoIcon;
    BOOL showAlbumIcon = model.showAlbumIcon;
    
    if (showVideoIcon) {
        _videoIcon.backgroundColor = coverColor;
    }
    if (showAlbumIcon) {
        _albumIcon.backgroundColor = coverColor;
    }
    
    _videoIconWidthConstraint.constant = showVideoIcon ? _albumIconWidthConstraint.constant : 0.0f;
    _iconSpaceConstraint.constant = showVideoIcon ? IconSpace : 0.0f;
    _videoIcon.hidden = !showVideoIcon;
    _albumIcon.hidden = !showAlbumIcon;
}

@end
