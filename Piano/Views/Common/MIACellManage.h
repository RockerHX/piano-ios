//
//  MIACellManage.h
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MIABaseTableViewCell.h"
#import "MIAProfileLiveCell.h"
#import "MIAProfileAlbumCell.h"
#import "MIAProfileVideoCell.h"
#import "MIAProfileReplayCell.h"
#import "MIAAlbumSongCell.h"
#import "MIAAlbumCommentCell.h"

typedef NS_ENUM(NSUInteger, MIACellType){

    MIACellTypeNormal,
    //主播的Profile
    MIACellTypeLive, //直播
    MIACellTypeAlbum,//专辑
    MIACellTypeVideo, //视频
    MIACellTypeReplay, //回放
    //专辑详情页
    MIACellTypeAlbumSong,//歌曲
    MIACellTypeAlbumComment,//评论
};

@interface MIACellManage : NSObject

+ (__kindof MIABaseTableViewCell *)getCellWithType:(MIACellType)type;

@end
