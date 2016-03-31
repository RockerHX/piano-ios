//
//  SongPreloader.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "SongPreloader.h"
#import "FSAudioStream.h"
#import "UserSetting.h"
#import "WebSocketMgr.h"
#import "NSString+IsNull.h"
#import "MusicItem.h"
#import "MusicMgr.h"
#import "PathHelper.h"
#import "FileLog.h"
#import "NSTimer+BlockSupport.h"

@interface SongPreloader()

@end

@implementation SongPreloader {
	FSAudioStream 	*_audioStream;
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

		__weak SongPreloader *weakPlayer = self;

		_audioStream.onCompletion = ^() {
			SongPreloader *strongPlayer = weakPlayer;
			[strongPlayer stop];
		};
		_audioStream.onStateChange = ^(FSAudioStreamState state) {
			if (kFSAudioStreamEndOfFile == state) {
				NSLog(@"Preload EndOfFile, stop audio stream");
				SongPreloader *strongPlayer = weakPlayer;
				[strongPlayer stop];
			}
		};
		_audioStream.onFailure = ^(FSAudioStreamError error, NSString *errorDescription) {
			[[FileLog standard] log:@"Preload AudioStream onFailure:%d, %@", error, errorDescription];
		};
	}
	return self;
}

- (void)dealloc {
	NSLog(@"SongPreloader dealoc");
}

- (void)preloadWithMusicItem:(MusicItem *)item {
//	if ([[FavoriteMgr standard] isItemCachedWithUrl:item.murl]) {
//		NSLog(@"#SongPreloader# preload ignored, has downloaded");
//		return;
//	}

	NSLog(@"#SongPreloader# preload");
	if (_delegate) {
		if ([_delegate songPreloaderIsPlayerLoadedThisUrl:item.murl]) {
			return;
		}
	}

	if (![UserSetting isAllowedToPlayNowWithURL:item.murl]) {
		return;
	}

	[[FileLog standard] log:@"preloadWithMusicItem %@", item.murl];
	_audioStream.url = [NSURL URLWithString:item.murl];
	[_audioStream preload];

	_currentItem = item;
}

- (void)stop {
	[_audioStream stop];
	_audioStream.url = nil;
}

@end
















