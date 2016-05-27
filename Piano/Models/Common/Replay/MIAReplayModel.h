//
//  MIAReplayModel.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIAReplayModel : NSObject

@property (nonatomic, copy) NSString *picUrl; //直播视频回放的图片地址
@property (nonatomic, copy) NSString *nick; //主播的昵称
@property (nonatomic, copy) NSString *roomID; //房间的id
@property (nonatomic, copy) NSString *coverID; //封面的ID
@property (nonatomic, copy) NSString *viewCnt; //观看的人
@property (nonatomic, copy) NSString *closeTime; //关闭的时间
@property (nonatomic, copy) NSString *title; //视频的名字
@property (nonatomic, copy) NSString *duration; //视频的长度
@property (nonatomic, copy) NSString *coverUrl; //直播中主播的图片
@property (nonatomic, copy) NSString *createTime; //创建的时间
@property (nonatomic, copy) NSString *replayUrl; //回放的地址
@property (nonatomic, copy) NSString *shareTitle; //分享的标题
@property (nonatomic, copy) NSString *shareUrl; //分享的地址

@end
