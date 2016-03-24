//
//  HXWatchLiveCommentCell.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatchLiveCommentCell.h"
#import "UIConstants.h"


@implementation HXWatchLiveCommentCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [_avatar addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(avatarTaped)]];
}

- (void)viewConfigure {
//    _contentLabel.preferredMaxLayoutWidth = SCREEN_WIDTH - ;
}

#pragma mark - Event Response
- (void)avatarTaped {
    if (_delegate && [_delegate respondsToSelector:@selector(commentCellShouldShowCommenter:)]) {
        [_delegate commentCellShouldShowCommenter:self];
    }
}

@end
