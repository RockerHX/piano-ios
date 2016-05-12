//
//  MIASongModel.h
//  Piano
//
//  Created by 刘维 on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIASongModel : NSObject

@property (nonatomic, copy) NSString *id;//歌曲的id
@property (nonatomic, copy) NSString *mp3Url;//歌曲的mp3地址
@property (nonatomic, copy) NSString *albumID;//专辑的id
@property (nonatomic, copy) NSString *addtime;//添加的时间
@property (nonatomic, copy) NSString *lyric;//歌词
@property (nonatomic, copy) NSString *nick;//名称
@property (nonatomic, copy) NSString *size;//大小
@property (nonatomic, copy) NSString *title;//标题
@property (nonatomic, copy) NSString *uID;//uid
@property (nonatomic, copy) NSString *coverUrl;//封面图的地址
@property (nonatomic, copy) NSString *duration;//歌曲的时长
@property (nonatomic, copy) NSString *fileID;//文件的id
@property (nonatomic, copy) NSString *status;//???

@property (nonatomic, copy)  NSString *summary;

@property (nonatomic, copy) NSString *songTime;

@end
