//
//  HXAlbumsCommentCell.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsCommentCell.h"
#import "HXCommentModel.h"
#import "UIImageView+WebCache.h"


@implementation HXAlbumsCommentCell

#pragma mark - Public Methods
- (void)updateCellWithComment:(HXCommentModel *)comment {
    [_avatar sd_setImageWithURL:[NSURL URLWithString:comment.avatarUrl]];
    _nickNameLabel.text = comment.nickName;
    _contentLabel.text = comment.content;
    _dateLabel.text = comment.date;
}

@end
