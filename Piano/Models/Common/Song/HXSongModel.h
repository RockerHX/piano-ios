//
//  HXSongModel.h
//  Piano
//
//  Created by miaios on 16/4/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

extern NSString * const kDefaultMusicID;

@interface HXSongModel : NSObject<NSCoding>

@property(nonatomic, assign) NSInteger  duration;

@property(nonatomic, strong)  NSString *mid; //id
@property(nonatomic, strong)  NSString *uID;
@property(nonatomic, strong)  NSString *albumID;
@property(nonatomic, strong)  NSString *title;
@property(nonatomic, strong)  NSString *summary;
@property(nonatomic, strong)  NSString *nickName; //nick
@property(nonatomic, strong)  NSString *lyric;
@property(nonatomic, strong)  NSString *coverUrl;
@property(nonatomic, strong)  NSString *mp3Url;

@property (nonatomic, copy) NSString *fileID;//文件的id
@property (nonatomic, copy) NSString *status;//???
@property (nonatomic, copy) NSString *size;//大小
@property (nonatomic, copy) NSString *addtime;//添加的时间

@property (nonatomic, assign)     BOOL  play;
@property (nonatomic, strong) NSString *durationPrompt; //时间格式

@end
