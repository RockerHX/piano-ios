//
//  MIAHostProfileModel.h
//  Piano
//
//  Created by 刘维 on 16/6/13.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostProfileFollowModel : NSObject

@property (nonatomic, copy) NSString *addtime; //添加的时间
@property (nonatomic, copy) NSString *deleted; //???
@property (nonatomic, copy) NSString *fuID; //关注人的uid
@property (nonatomic, copy) NSString *id; //？？？
@property (nonatomic, copy) NSString *live; // 直播的状态
@property (nonatomic, copy) NSString *nick; //昵称
@property (nonatomic, copy) NSString *status; //状态 1为 你关注主播 2为 你跟主播相互关注
@property (nonatomic, copy) NSString *uID; //uid
@property (nonatomic, copy) NSString *userpic; //头像的照片

@end

@interface HostMusicAlbumModel : NSObject

@property (nonatomic, copy) NSString *addtime;//添加的时间
@property (nonatomic, copy) NSString *coverID; //？？？
@property (nonatomic, copy) NSString *coverUrl;//专辑封面的图片
@property (nonatomic, copy) NSString *id; //专辑的id
@property (nonatomic, copy) NSString *status; //？？？
@property (nonatomic, copy) NSString *summary; //专辑的简介
@property (nonatomic, copy) NSString *title; //专辑的标题
@property (nonatomic, copy) NSString *uID;//???

@end

@interface MIAHostProfileModel : NSObject

@property (nonatomic, copy) NSString *bio; //个人简介
@property (nonatomic, copy) NSString *fansCnt; //粉丝数
@property (nonatomic, copy) NSString *followCnt; //关注数
@property (nonatomic, copy) NSString *gender; //性别 0为位置 1为男性 2为女性
@property (nonatomic, copy) NSString *lastNotiUID; //???
@property (nonatomic, copy) NSString *mcoin;//该账户在安卓账号下面的m币余额
@property (nonatomic, copy) NSString *mcoinApple;//在账户在apple账号下面的m币余额
@property (nonatomic, copy) NSString *musicAlbumCnt;//专辑数
@property (nonatomic, copy) NSString *nick;//昵称
@property (nonatomic, copy) NSString *notifyCnt;//？？？
@property (nonatomic, copy) NSString *pictureID;//???
@property (nonatomic, copy) NSString *uID;// uid
@property (nonatomic, copy) NSString *userpic; //头像图片
@property (nonatomic, copy) NSArray <HostProfileFollowModel *> *followList; //关注列表
@property (nonatomic, copy) NSArray <HostMusicAlbumModel *> *musicAlbum; //打赏过的专辑

@end
