//
//  MIAProfileModel.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumModel.h"
#import "MIAVideoModel.h"
#import "MIAReplayModel.h"

@interface MIAProfileModel : NSObject

@property (nonatomic, copy) NSString *uID; //id
@property (nonatomic, copy) NSString *nick;//名字
@property (nonatomic, copy) NSString *gender; //性别 0为位置 1为男性 2为女性
@property (nonatomic, copy) NSString *bio; //签名
@property (nonatomic, copy) NSString *fansCnt;//粉丝数
@property (nonatomic, copy) NSString *followCnt;//关注数
@property (nonatomic, copy) NSString *follow; //关注的状态
@property (nonatomic, copy) NSString *coverUrl; //主播的图片
@property (nonatomic, copy) NSString *userpic; //用户的图片
@property (nonatomic, copy) NSString *coverColor;//昵称跟签名的背景色

@property (nonatomic, copy) NSString *live; //是否在直播的状态
@property (nonatomic, copy) NSString *liveDate;//直播的时间
@property (nonatomic, copy) NSString *liveTitle;//直播的描述的内容
@property (nonatomic, copy) NSString *liveViewCnt;//统计 总共多少人看
@property (nonatomic, copy) NSString *liveOnlineCnt;//正在观看的人数
@property (nonatomic, copy) NSString *liveRoomID; //直播房间的id
@property (nonatomic, copy) NSString *liveRoomCoverUrl; //直播房间的图片
@property (nonatomic, assign) NSInteger horizontal; //是否横屏直播

@property (nonatomic, copy) NSString *mcoinApple; //ios端  我的m币
@property (nonatomic, copy) NSString *mcoin;//安卓端 我的M币


@property (nonatomic, copy) NSString *lastNotiUID;
@property (nonatomic, copy) NSString *notifyCnt;
@property (nonatomic, copy) NSString *pictureID;

@property (nonatomic, copy) NSString *musicAlbumCnt; //专辑的数量
@property (nonatomic, strong) NSArray<MIAAlbumModel *> *musicAlbum; //专辑
@property (nonatomic, copy) NSString *videoCnt; //视频的数量
@property (nonatomic, strong) NSArray<MIAVideoModel *> *video; //视频
@property (nonatomic, copy) NSString *replayCnt;  //直播回放的数量
@property (nonatomic, strong) NSArray<MIAReplayModel *> *replay; //直播回放


@end
