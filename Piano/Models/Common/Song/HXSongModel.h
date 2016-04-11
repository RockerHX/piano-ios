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

@property(nonatomic, strong)  NSString *mid;
@property(nonatomic, strong)  NSString *uID;
@property(nonatomic, strong)  NSString *albumID;
@property(nonatomic, strong)  NSString *title;
@property(nonatomic, strong)  NSString *summary;
@property(nonatomic, strong)  NSString *nickName;
@property(nonatomic, strong)  NSString *songName;
@property(nonatomic, strong)  NSString *singerName;
@property(nonatomic, strong)  NSString *coverUrl;
@property(nonatomic, strong)  NSString *mp3Url;

@property (nonatomic, assign)     BOOL  play;
@property (nonatomic, strong) NSString *durationPrompt;

@end
