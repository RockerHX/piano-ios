//
//  HXLiveCommentBarrageCell.m
//  Piano
//
//  Created by miaios on 16/5/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveCommentBarrageCell.h"


@implementation HXLiveCommentBarrageCell

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
    ;
}

#pragma mark - Public Methods
- (void)updateWithBarrage:(HXBarrageModel *)barrage {
    HXCommentModel *comment = barrage.comment;
    NSString *nickName = [comment.nickName stringByAppendingString:@":"];
    self.contentLabel.text = [nickName stringByAppendingString:comment.content];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc] initWithAttributedString:self.contentLabel.attributedText];
    [content addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[self.contentLabel.text rangeOfString:nickName]];
    self.contentLabel.attributedText = content;
    
    if (comment.backAlbum && comment.backGift) {
        _firstFlagIcon.image = [UIImage imageNamed:@"LC-BarrageRewardIcon"];
        _secondFlagIcon.image = [UIImage imageNamed:@"LC-BarrageGiftIcon"];
    } else if (comment.backAlbum && !comment.backGift) {
        _firstFlagIcon.image = [UIImage imageNamed:@"LC-BarrageRewardIcon"];
        _secondFlagIcon.image = nil;
    }  else if (!comment.backAlbum && comment.backGift) {
        _firstFlagIcon.image = [UIImage imageNamed:@"LC-BarrageGiftIcon"];
        _secondFlagIcon.image = nil;
    } else {
        _firstFlagIcon.image = nil;
        _secondFlagIcon.image = nil;
    }
}

@end
