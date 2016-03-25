//
//  HXWatcherCell.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherCell.h"
#import "UIConstants.h"


@implementation HXWatcherCell

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
    [self displayWithCommenter:nil];
}

#pragma mark - Public Methods
- (void)displayWithCommenter:(id)commenter {
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithString:_contentLabel.text];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[_contentLabel.text rangeOfString:@"评论用户:"]];
    _contentLabel.attributedText = content;
}

@end
