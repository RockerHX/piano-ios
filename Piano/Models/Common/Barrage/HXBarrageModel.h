//
//  HXBarrageModel.h
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCommentModel.h"


typedef NS_ENUM(NSUInteger, HXBarrageType) {
    HXBarrageTypeEnter,
    HXBarrageTypeAttention,
    HXBarrageTypeShare,
    HXBarrageTypeGift,
    HXBarrageTypeReward,
    HXBarrageTypeComment,
};


@interface HXBarrageModel : NSObject

@property (nonatomic, strong) NSString *uID;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *signature;

@property (nonatomic, assign)  HXBarrageType  type;
@property (nonatomic, strong)       NSString *prompt;
@property (nonatomic, strong) HXCommentModel *comment;

@end
