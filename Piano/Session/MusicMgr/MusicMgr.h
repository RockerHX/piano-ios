//
//  MusicMgr.h
//  mia
//
//  Created by linyehui on 2015/10/23.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "HXSongModel.h"

extern NSString * const MusicMgrNotificationKey_RemoteControlEvent;
extern NSString * const MusicMgrNotificationKey_PlayerEvent;
extern NSString * const MusicMgrNotificationKey_sID;

extern NSString * const MusicMgrNotificationRemoteControlEvent;
extern NSString * const MusicMgrNotificationPlayerEvent;

typedef NS_ENUM(NSUInteger, MiaPlayerEvent) {
	MiaPlayerEventDidPlay,
	MiaPlayerEventDidPause,
	MiaPlayerEventDidCompletion
};

typedef void(^PlayWith3GOnceTimeBlock)(BOOL isAllowed);

@interface MusicMgr : NSObject<NSCoding>

/**
 *  使用单例初始化
 *
 */
+ (MusicMgr *)standard;

@property (nonatomic, assign) NSInteger  currentIndex;
@property (nonatomic, strong) HXSongModel *currentItem;
@property (nonatomic, strong, readonly) NSString *currentUrlInPlayer;

@property (nonatomic, assign, readonly)            NSInteger  musicCount;
@property (nonatomic, strong, readonly) NSArray<HXSongModel *> *playList;

@property (nonatomic, assign) BOOL  isShufflePlay;
@property (nonatomic, assign) BOOL  isInterruption;

- (BOOL)isCurrentHostObject:(id)hostObject;
- (void)setPlayList:(NSArray *)playList hostObject:(id)hostObject;
- (void)setPlayListWithItem:(HXSongModel *)item hostObject:(id)hostObject;

// 播放当前列表对应下标的歌曲
- (void)playWithIndex:(NSInteger)index;

- (void)playCurrent;
- (void)playPrevios;
- (void)playNext;

- (void)checkIsAllowToPlayWith3GOnceTimeWithBlock:(PlayWith3GOnceTimeBlock)playWith3GOnceTimeBlock;
- (BOOL)isPlayWith3GOnceTime;
- (BOOL)isPlaying;
- (BOOL)isPlayingWithUrl:(NSString *)url;
- (void)pause;
- (void)stop;

- (float)durationSeconds;
- (float)currentPlayedSeconds;

/**
 * Position within the stream, where 0 is the beginning
 * and 1.0 is the end.
 */
- (float)currentPlayedPostion;
- (void)seekToPosition:(float)postion;

@end
