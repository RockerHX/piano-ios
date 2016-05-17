//
//  HXBarrageModel.m
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXBarrageModel.h"


@implementation HXBarrageModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
             @"avatarUrl": @"userpic",
             @"signature": @"bio"};
}

#pragma mark - Property
- (void)setType:(HXBarrageType)type {
    NSString *actionString = nil;
    switch (type) {
            case HXBarrageTypeEnter: {
                actionString = @"进入了直播间";
                break;
            }
            case HXBarrageTypeAttention: {
                actionString = @"关注了主播";
                break;
            }
            case HXBarrageTypeShare: {
                actionString = @"分享了本次直播";
                break;
            }
            case HXBarrageTypeGift: {
                actionString = [NSString stringWithFormat:@"赠送给主播%@", nil];
                break;
            }
            case HXBarrageTypeReward: {
                actionString = [NSString stringWithFormat:@"打赏了主播个人专辑%@M币", nil];
                break;
            }
            default: {
                break;
            }
    }
    _prompt = [_nickName stringByAppendingString:actionString];
}

- (void)setComment:(HXCommentModel *)comment {
    _comment = comment;
    _prompt = [_comment.nickName stringByAppendingFormat:@":%@", _comment.content];
}

@end
