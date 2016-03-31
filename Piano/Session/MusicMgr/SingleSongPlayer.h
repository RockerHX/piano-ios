//
//  SingleSongPlayer.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MusicItem;
@class SingleSongPlayer;

@protocol SingleSongPlayerDelegate <NSObject>

- (void)singleSongPlayerDidPlay;
- (void)singleSongPlayerDidPause;
- (void)singleSongPlayerDidCompletion;
- (void)singleSongPlayerDidBufferStream;
- (void)singleSongPlayerDidFailure;

@end


@interface SingleSongPlayer : NSObject

@property (nonatomic, weak) id <SingleSongPlayerDelegate> delegate;
@property (strong, nonatomic) MusicItem * currentItem;
@property (strong, nonatomic, readonly) NSString * currentUrl;

- (void)playWithMusicItem:(MusicItem *)item;

- (BOOL)isPlaying;
- (BOOL)isPlayingWithUrl:(NSString *)url;

- (void)pause;
- (void)stop;

- (float)durationSeconds;
- (float)currentPlayedSeconds;
- (float)currentPlayedPostion;
- (void)seekToPosition:(float)postion;

@end
