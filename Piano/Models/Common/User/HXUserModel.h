//
//  HXUserModel.h
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"
#import "HXUserRole.h"

@interface HXUserModel : NSObject

@property (nonatomic, copy) NSString *bio;//签名
@property (nonatomic, copy) NSString *coverUrl; //封面图
@property (nonatomic, copy) NSString *fansCnt;//粉丝数
@property (nonatomic, copy) NSString *followCnt;//关注数
@property (nonatomic, copy) NSString *gender;//性别
@property (nonatomic, copy) NSString *lastNotiUID;
@property (nonatomic, copy) NSString *liveCoverUrl;//直播的封面地址
@property (nonatomic, copy) NSString *mcoin;//安卓平台下账号的M币余额
@property (nonatomic, copy) NSString *mcoinApple;//ios平台账号的M币余额
@property (nonatomic, copy) NSString *nickName;//昵称
@property (nonatomic, assign) NSInteger  notifyCount;
@property (nonatomic, copy) NSString *onlineID;//线上的id
@property (nonatomic, copy) NSString *pictureID;
@property (nonatomic, assign) HXUserRole  role;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *uID;
@property (nonatomic, copy) NSString *avatarUrl;//头像地址
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *notifyAvatar;


@end
