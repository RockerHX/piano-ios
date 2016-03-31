//
//  SingleSongPlayer.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import "SingleSongPlayer.h"
#import "FSAudioStream.h"
#import <AVFoundation/AVFoundation.h>
#import "PathHelper.h"
#import "UserSetting.h"
#import "WebSocketMgr.h"
#import "NSObject+BlockSupport.h"
#import "NSString+IsNull.h"
#import "MusicItem.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MusicMgr.h"
#import "FileLog.h"
#import "SDWebImageDownloader.h"

@interface SingleSongPlayer()

@end

@implementation SingleSongPlayer {
	FSAudioStream 		*_audioStream;
	FSAudioStreamState	_audioState;

	// FSAudioStream开始播放和FSAudioStream的状态改变中间存在时间差
	// 界面刷新要求isPlaying及时更新，所以加上这个变量进行控制
	// @eden 2016-03-03
	BOOL				_tryingPlay;
}

- (id)init {
	self = [super init];
	if (self) {
		// init audioStream
		FSStreamConfiguration *defaultConfiguration = [[FSStreamConfiguration alloc] init];
		defaultConfiguration.cacheDirectory = [PathHelper playCacheDir];
		defaultConfiguration.maxDiskCacheSize = 209715200;	// 200MB
		_audioStream = [[FSAudioStream alloc] initWithConfiguration:defaultConfiguration];
		_audioStream.strictContentTypeChecking = NO;
		_audioStream.defaultContentType = @"audio/mpeg";

		__weak SingleSongPlayer *weakPlayer = self;
		_audioStream.onCompletion = ^() {
			__strong SingleSongPlayer *strongPlayer = weakPlayer;
			[strongPlayer stop];
			if ([strongPlayer delegate]) {
				[[strongPlayer delegate] singleSongPlayerDidCompletion];
			}
		};
		_audioStream.onStateChange = ^(FSAudioStreamState state) {
			NSLog(@"FSAudioStreamState change:%ld", (long)state);
			__strong SingleSongPlayer *strongPlayer = weakPlayer;
			if (!strongPlayer) {
				NSLog(@"_audioStream.onStateChange, strongPlayer is null");
				return;
			}
			strongPlayer->_audioState = state;

			if (kFSAudioStreamEndOfFile == state) {
				if ([strongPlayer delegate]) {
					[[strongPlayer delegate] singleSongPlayerDidBufferStream];
				}
			}

			// 状态延迟的一个重要原因就是因为先stop再播放，所以stoped的状态这个需要过滤掉 @eden
			// @eden 2016-03-03
			if (kFsAudioStreamUnknownState == state
//				|| kFsAudioStreamStopped == state
				|| kFsAudioStreamFailed == state
				|| kFsAudioStreamPlaying == state
				|| kFsAudioStreamPaused == state
				|| kFsAudioStreamRetryingFailed == state) {
				_tryingPlay = NO;
			}
		};

		_audioStream.onFailure = ^(FSAudioStreamError error, NSString *errorDescription) {
			[[FileLog standard] log:@"AudioStream onFailure:%d, %@", error, errorDescription];

			__strong SingleSongPlayer *strongPlayer = weakPlayer;
			if ([strongPlayer delegate]) {
				[[strongPlayer delegate] singleSongPlayerDidFailure];
			}
		};
	}
	return self;
}

- (void)dealloc {
	NSLog(@"SingleSongPlayer dealoc");
}

- (NSString *)currentUrl {
	if (_tryingPlay) {
		return _currentItem.murl;
	} else {
		return _audioStream.url.absoluteString;
	}
}

- (void)playWithMusicItem:(MusicItem *)item {
	[[FileLog standard] log:@"playWithMusicItem %@, %@", item.name, item.murl];

	if ([self isPlayingWithUrl:item.murl]) {
		// 同一个模块再次播放同一首歌，什么都不做
		NSLog(@"play the same song in the same model, play will be ignored.");
				return;
	}

	if (![UserSetting isAllowedToPlayNowWithURL:item.murl]) {
		[self checkBeforePlayWithMusicItem:item];
		return;
	}

	[self playWithoutCheckWithUrl:item.murl title:item.name artist:item.singerName cover:item.purl];
	_currentItem = item;
}

- (BOOL)isPlaying {
	if (_audioStream) {
		if (_tryingPlay) {
//			NSLog(@"isPlaying return YES by tryPlay, _audioState: %ld", (long)_audioState);
			return YES;
		} else {
			return [_audioStream isPlaying];
		}
	} else {
		return NO;
	}
}

- (BOOL)isPlayingWithUrl:(NSString *)url {
	if (![self isPlaying]) {
		return NO;
	}

//	NSLog(@"isPlayingWithUrl\n===%@\n+++%@\n---%@", url, _audioStream.url.absoluteString, _currentItem.murl);
	if (_tryingPlay) {
		return [_currentItem.murl isEqualToString:url];
	} else {
		return [_audioStream.url.absoluteString isEqualToString:url];
	}
}

- (void)play {
	[[FileLog standard] log:@"play: %@", [[_audioStream url] absoluteString]];
	if (![_audioStream url])
		return;

	if (![UserSetting isAllowedToPlayNowWithURL:[[_audioStream url] absoluteString]]) {
		[[MusicMgr standard] checkIsAllowToPlayWith3GOnceTimeWithBlock:^(BOOL isAllowed) {
			if (isAllowed) {
				[self play];
			}
		}];

		return;
	}

	NSLog(@"play - resume play from pause");
	[_audioStream pause];

	if (_delegate) {
		[_delegate singleSongPlayerDidPlay];
	}
}

- (void)pause {
	[[FileLog standard] log:@"pause: %@", [[_audioStream url] absoluteString]];
	[_audioStream pause];

	if ([_audioStream isPlaying]) {
		if (_delegate) {
			[_delegate singleSongPlayerDidPlay];
		}
	} else {
		if (_delegate) {
			[_delegate singleSongPlayerDidPause];
		}
	}

}

- (void)stop {
	[_audioStream stop];
	_audioStream.url = nil;

	if (_delegate) {
		[_delegate singleSongPlayerDidPause];
	}
}

- (float)durationSeconds {
    float totalSeconds = [_audioStream duration].minute * 60.0 + [_audioStream duration].second;
    return totalSeconds;
}

- (float)currentPlayedSeconds {
    return _audioStream.currentTimePlayed.playbackTimeInSeconds;
}

- (float)currentPlayedPostion {
	if (!_audioStream) {
		return 0.0;
	}

	return [_audioStream currentTimePlayed].position;
}

- (void)seekToPosition:(float)postion {
	if (!_audioStream) {
		return;
	}

	FSStreamPosition destPostion;
	destPostion.position = postion;

	[_audioStream seekToPosition:destPostion];
}

#pragma mark -private method

- (void)playWithoutCheckWithUrl:(NSString*)url title:(NSString *)title artist:(NSString *)artist cover:(NSString *)cover {
	if ([[[_audioStream url] absoluteString] isEqualToString:url]) {
		// 不要根据url来判断是否有歌曲在播放，因为播放完成或者stop都会把url清掉
		// 同一首歌，暂停状态，直接调用pause恢复播放就可以了
		if (_audioState == kFsAudioStreamStopped) {
			NSLog(@"resume music from interruption.");
			[self playAnotherWirUrl:url];
		} else if ([_audioStream isPlaying]) {
			NSLog(@"resume music from pause error, stop and play again.");
			[self playAnotherWirUrl:url];
		} else {
			NSLog(@"playWithUrl - resume play from pause");
			[_audioStream pause];

			if (_delegate) {
				[_delegate singleSongPlayerDidPlay];
			}
		}
	} else {
		// 切换歌曲
		[self playAnotherWirUrl:url];
	}

	[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:cover]
														  options:0 progress:nil completed:
	 ^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
		if (image && finished) {
			[self setMediaInfo:image andTitle:title andArtist:artist];
		} else {
			[self setMediaInfo:nil andTitle:title andArtist:artist];
		}
	}];
}

- (void)playAnotherWirUrl:(NSString *)url {
	NSLog(@"stop - stop before playAnotherWirUrl");
	[_audioStream stop];
	_tryingPlay = YES;
	[self bs_performBlock:^{
		NSLog(@"delayPlayHandlerWithUrl");
		[_audioStream playFromURL:[NSURL URLWithString:url]];

		if (_delegate) {
			[_delegate singleSongPlayerDidPlay];
		}
	} afterDelay:0.5f];
}

- (void)checkBeforePlayWithMusicItem:(MusicItem *)item {
	[[MusicMgr standard] checkIsAllowToPlayWith3GOnceTimeWithBlock:^(BOOL isAllowed) {
		if (isAllowed) {
			[self playWithoutCheckWithUrl:item.murl title:item.name artist:item.singerName cover:item.purl];
		}
	}];
}

#pragma mark - audio operations
- (void)setMediaInfo:(UIImage *)coverImage andTitle:(NSString *)title andArtist:(NSString *)artist {
	if ([NSString isNull:title] || [NSString isNull:artist]) {
		return;
	}

	dispatch_sync(dispatch_get_main_queue(), ^ {
		if (!NSClassFromString(@"MPNowPlayingInfoCenter"))
			return ;

		NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];

		[dict setObject:title forKey:MPMediaItemPropertyAlbumTitle];
		[dict setObject:artist forKey:MPMediaItemPropertyArtist];

		float totalSeconds = [_audioStream duration].minute * 60.0 + [_audioStream duration].second;
		[dict setObject:[NSNumber numberWithFloat:totalSeconds] forKey:MPMediaItemPropertyPlaybackDuration];
		[dict setObject:[NSNumber numberWithFloat:[_audioStream currentTimePlayed].playbackTimeInSeconds] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];

		if (coverImage) {
			MPMediaItemArtwork * mArt = [[MPMediaItemArtwork alloc] initWithImage:coverImage];
			[dict setObject:mArt forKey:MPMediaItemPropertyArtwork];
		}
		
		[[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];

	});
}


@end
















