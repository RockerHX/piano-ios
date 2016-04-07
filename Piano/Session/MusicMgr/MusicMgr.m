//
//  MusicMgr.m
//  mia
//
//  Created by linyehui on 2015/10/23.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import "MusicMgr.h"
#import "SingleSongPlayer.h"
#import "SongPreloader.h"
#import "WebSocketMgr.h"
#import "UserSetting.h"
#import "FileLog.h"
#import "UIAlertView+BlocksKit.h"
#import "NSObject+BlockSupport.h"
#import "PathHelper.h"
#import "HXUserSession.h"


NSString * const MusicMgrNotificationKey_RemoteControlEvent	= @"RemoteControlEvent";
NSString * const MusicMgrNotificationKey_PlayerEvent		= @"PlayerEvent";
NSString * const MusicMgrNotificationKey_MusicID			= @"MusicID";

NSString * const MusicMgrNotificationRemoteControlEvent		= @"MusicMgrNotificationRemoteControlEvent";
NSString * const MusicMgrNotificationPlayerEvent			= @"MusicMgrNotificationPlayerEvent";

const NSInteger kInvalidateCurrentIndex = -1;

@interface MusicMgr() <SingleSongPlayerDelegate, SongPreloaderDelegate>

@end

@implementation MusicMgr {
	NSString				*_hostObjectName;
	long					_hostObjectID;

	SingleSongPlayer		*_player;
	SongPreloader			*_preloader;

	UIAlertView 			*_playWith3GAlertView;
	BOOL					_playWith3GOnceTime;		// 本次网络切换期间允许用户使用3G网络播放，网络切换后，自动重置这个开关
}

/**
 *  使用单例初始化
 *
 */
+ (MusicMgr *)standard {
    static MusicMgr *aMgr = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
		aMgr = [NSKeyedUnarchiver unarchiveObjectWithFile:[PathHelper playlistArchivePathWithUID:[[HXUserSession session] uid]]];
		if (!aMgr) {
			aMgr = [[self alloc] init];
		} else {
			[aMgr loadConfig];
		}
    });
    return aMgr;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		[self loadConfig];
	}

	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MusicMgrNotificationRemoteControlEvent object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:NetworkNotificationReachabilityStatusChange object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
}

- (void)loadConfig {
	_player = [[SingleSongPlayer alloc] init];
	_player.delegate = self;

	_preloader = [[SongPreloader alloc] init];
	_preloader.delegate = self;

	// 添加通知，拔出耳机后暂停播放
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(remountControlEvent:) name:MusicMgrNotificationRemoteControlEvent object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReachabilityStatusChange:) name:NetworkNotificationReachabilityStatusChange object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruption:) name:AVAudioSessionInterruptionNotification object:nil];
}

#pragma mark - Getter and Setter
- (HXSongModel *)currentItem {
	if (_playList.count <= 0) {
		return nil;
	}

	if (_currentIndex < 0 || _currentIndex >= _playList.count) {
		return nil;
	}

	return _playList[_currentIndex];
}

- (NSString *)currentUrlInPlayer {
	if (!_player) {
		return nil;
	}

	return _player.currentUrl;
}

- (NSInteger)musicCount {
    return (_playList.count - 1);
}

#pragma mark - Public Methods
- (BOOL)isCurrentHostObject:(id)hostObject {
	if (0 == _hostObjectID) {
		return NO;
	}

	long objectID = (long)(__bridge void *)hostObject;
	return (objectID == _hostObjectID);
}

- (void)setPlayList:(NSArray *)playList hostObject:(id)hostObject {
	HXSongModel *lastItem = self.currentItem;
	_playList = [[NSArray alloc] initWithArray:playList];

	if (![self isCurrentHostObject:hostObject]) {
		_hostObjectName = NSStringFromClass([hostObject class]);
		_hostObjectID = (long)(__bridge void *)hostObject;

		[_player stop];
		[_preloader stop];
		_currentIndex = 0;
		_isShufflePlay = NO;
	} else {
		// 只更新列表但是不更新当前播放的歌曲
		NSInteger updatedIndex = [self getCurrentIndexWithItem:lastItem];
		if (kInvalidateCurrentIndex == updatedIndex) {
			// 如果更新后的列表没有这首歌了
			NSLog(@"setPlayList, It must be a bug.");
			_currentIndex = 0;
		} else {
			_currentIndex = updatedIndex;
		}
	}

	[self saveChanges];
}

- (void)setPlayListWithItem:(HXSongModel *)item hostObject:(id)hostObject {
	NSArray *playList = [[NSArray alloc] initWithObjects:item, nil];
	[self setPlayList:playList hostObject:hostObject];
}

#pragma mark - Player Methods
- (void)playWithIndex:(NSInteger)index {
	if (_playList.count <= 0) {
		return;
	}

	if (index < 0 || index >= _playList.count) {
		return;
	}

	HXSongModel *item = _playList[index];
	if (item) {
        self.currentItem.play = NO;
		[_player playWithItem:item];
		_currentIndex = index;
	}
}

- (void)playWithItem:(HXSongModel *)item {
	NSUInteger count = [_playList count];

	if (count <= 0) {
		return;
	}

	for (int i = 0 ; i < count; i++) {
		HXSongModel *it = [_playList objectAtIndex:i];
		if ([it.mid isEqualToString:item.mid]) {
			[_preloader stop];
			[_player playWithItem:item];
			_currentIndex = i;

			return;
		}

	}
}

- (void)playCurrent {
	[_player playWithItem:self.currentItem];
}

- (void)playPrevios {
	if (_playList.count <= 0) {
		return;
	}
    
    self.currentItem.play = NO;

	NSInteger prevIndex = [self getPrevIndex];
	[_player playWithItem:_playList[prevIndex]];
	_currentIndex = prevIndex;
}

- (void)playNext {
	if (_playList.count <= 0) {
		return;
    }
    
    self.currentItem.play = NO;

	NSInteger nextIndex = [self getNextIndex];
	[_player playWithItem:_playList[nextIndex]];
	_currentIndex = nextIndex;
}

- (void)checkIsAllowToPlayWith3GOnceTimeWithBlock:(PlayWith3GOnceTimeBlock)playWith3GOnceTimeBlock {
	[_player pause];

	if (![[WebSocketMgr standard] isNetworkEnable]) {
		return;
	}

	if (_playWith3GOnceTime && playWith3GOnceTimeBlock) {
		playWith3GOnceTimeBlock(YES);
		return;
	}

	if (_playWith3GAlertView) {
		NSLog(@"Last play with 3G alert view is still showing");
		if (playWith3GOnceTimeBlock) {
			playWith3GOnceTimeBlock(NO);
		}
		return;
	}

	static NSString *kAlertTitleError = @"网络连接提醒";
	static NSString *kAlertMsgNotAllowToPlayWith3G = @"您现在使用的是运营商网络，继续播放会产生流量费用。是否允许在2G/3G/4G网络下播放？";

	_playWith3GAlertView = [UIAlertView bk_showAlertViewWithTitle:kAlertTitleError
														  message:kAlertMsgNotAllowToPlayWith3G
												cancelButtonTitle:@"取消"
												otherButtonTitles:@[@"允许播放"]
														  handler:
							^(UIAlertView *alertView, NSInteger buttonIndex) {
								if (alertView.cancelButtonIndex == buttonIndex) {
									NSLog(@"cancel");
									_playWith3GAlertView = nil;
									if (playWith3GOnceTimeBlock) {
										playWith3GOnceTimeBlock(NO);
									}
								} else {
									NSLog(@"allow to play");
									_playWith3GAlertView = nil;
									_playWith3GOnceTime = YES;
									if (playWith3GOnceTimeBlock) {
										playWith3GOnceTimeBlock(YES);
									}
								}
							}];
}

- (BOOL)isPlayWith3GOnceTime {
	return _playWith3GOnceTime;
}

- (BOOL)isPlaying {
	return [_player isPlaying];
}

- (BOOL)isPlayingWithUrl:(NSString *)url {
	return [_player isPlayingWithUrl:url];
}

- (void)pause {
	[_player pause];
}

- (void)stop {
	[_player stop];
	[_preloader stop];
}

- (float)durationSeconds {
	return [_player durationSeconds];
}

- (float)currentPlayedSeconds {
	return [_player currentPlayedSeconds];
}

- (float)currentPlayedPostion {
	return [_player currentPlayedPostion];
}

- (void)seekToPosition:(float)postion {
	return [_player seekToPosition:postion];
}

#pragma mark - Private Methods
- (NSInteger)getPrevIndex {
	if (_playList.count <= 0) {
		return 0;
	}

	if (_isShufflePlay) {
		return [self getNextIndex];
	}

	NSInteger prevIndex = _currentIndex - 1;
	if (prevIndex < 0 || prevIndex >= _playList.count) {
		return 0;
	} else {
		return prevIndex;
	}
}

- (NSInteger)getNextIndex {
	if (_playList.count <= 0) {
		return 0;
	}

	NSInteger lastIndex = _currentIndex;
	NSInteger nextIndex = lastIndex;

	if (_isShufflePlay) {
		nextIndex = arc4random() % _playList.count;
		if (nextIndex == lastIndex) {
			nextIndex = lastIndex + 1;
		}
	} else {
		nextIndex = _currentIndex + 1;
	}

	if (nextIndex < 0 || nextIndex >= _playList.count) {
		return 0;
	} else {
		return nextIndex;
	}
}

- (NSInteger)getCurrentIndexWithItem:(HXSongModel *)item {
	NSInteger currentIndex = -1;
	for (int i = 0 ; i < _playList.count; i++) {
		HXSongModel *it = [_playList objectAtIndex:i];
		if ([it.mid isEqualToString:item.mid]) {
			currentIndex = i;
			return currentIndex;
		}
	}

	return currentIndex;
}

- (BOOL)saveChanges {
	NSString *fileName = [PathHelper playlistArchivePathWithUID:[[HXUserSession session] uid]];
	if (![NSKeyedArchiver archiveRootObject:self toFile:fileName]) {
		NSLog(@"archive share list failed.");
		if ([[NSFileManager defaultManager] removeItemAtPath:fileName error:nil]) {
			NSLog(@"delete share list archive file.");
		}
		return NO;
	}

	return YES;
}

#pragma mark - NSCoding
//将对象编码(即:序列化)
- (void) encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_currentItem forKey:@"currentItem"];
	[aCoder encodeObject:_playList forKey:@"playList"];
	[aCoder encodeInteger:_currentIndex forKey:@"currentIndex"];
	[aCoder encodeInteger:_isShufflePlay forKey:@"isShufflePlay"];
}

//将对象解码(反序列化)
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
	if (self=[super init]) {
		_currentItem = [aDecoder decodeObjectForKey:@"currentItem"];
		_playList = [aDecoder decodeObjectForKey:@"playList"];
		_currentIndex = [aDecoder decodeIntegerForKey:@"currentIndex"];
		_isShufflePlay = [aDecoder decodeIntegerForKey:@"isShufflePlay"];
	}
	return (self);
}

#pragma mark - Notification
/**
 *  一旦输出改变则执行此方法
 *
 *  @param notification 输出改变通知对象
 */
- (void)routeChange:(NSNotification *)notification {
	NSDictionary *dic = notification.userInfo;
	int changeReason = [dic[AVAudioSessionRouteChangeReasonKey] intValue];
	//等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
	if (changeReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
		AVAudioSessionRouteDescription *routeDescription = dic[AVAudioSessionRouteChangePreviousRouteKey];
		AVAudioSessionPortDescription *portDescription = [routeDescription.outputs firstObject];
		//原设备为耳机则暂停
		if ([portDescription.portType isEqualToString:@"Headphones"]) {
			dispatch_async(dispatch_get_main_queue(), ^{
				if ([_player isPlaying]) {
					[_player pause];
					[[FileLog standard] log:@"routechange last device is headphone, pause"];
				}
			});
		}
	}
}

- (void)remountControlEvent:(NSNotification *)notification {
	UIEvent* event = [[notification userInfo] valueForKey:MusicMgrNotificationKey_RemoteControlEvent];
	NSLog(@"%li,%li",(long)event.type,(long)event.subtype);
	if(event.type == UIEventTypeRemoteControl){
		switch (event.subtype) {
			case UIEventSubtypeRemoteControlPlay:
				[self playCurrent];
				break;
			case UIEventSubtypeRemoteControlPause:
				[self pause];
				break;
			case UIEventSubtypeRemoteControlTogglePlayPause:
				[self pause];
				break;
			case UIEventSubtypeRemoteControlNextTrack:
				[self playNext];
				break;
			case UIEventSubtypeRemoteControlPreviousTrack:
				[self playPrevios];
				break;
			case UIEventSubtypeRemoteControlBeginSeekingForward:
				NSLog(@"Begin seek forward...");
				break;
			case UIEventSubtypeRemoteControlEndSeekingForward:
				NSLog(@"End seek forward...");
				break;
			case UIEventSubtypeRemoteControlBeginSeekingBackward:
				NSLog(@"Begin seek backward...");
				break;
			case UIEventSubtypeRemoteControlEndSeekingBackward:
				NSLog(@"End seek backward...");
				break;
			default:
				break;
		}
	}
}

- (void)notificationReachabilityStatusChange:(NSNotification *)notification {
	_playWith3GOnceTime = NO;

	if (![_player isPlaying]) {
		return;
	}

	if ([UserSetting isAllowedToPlayNowWithURL:_player.currentItem.mp3Url]) {
		return;
	}

	[_player stop];
	[self checkIsAllowToPlayWith3GOnceTimeWithBlock:^(BOOL isAllowed) {
		if (isAllowed) {
			[self playCurrent];
		}
	}];
}

- (void)interruption:(NSNotification*)notification {
	NSDictionary *interuptionDict = notification.userInfo;
	NSInteger interuptionType = [[interuptionDict valueForKey:AVAudioSessionInterruptionTypeKey] integerValue];
	switch (interuptionType) {
		case AVAudioSessionInterruptionTypeBegan:
			[[FileLog standard] log:@"Audio Session Interruption case started."];
			_isInterruption = YES;
			break;

		case AVAudioSessionInterruptionTypeEnded:
			[[FileLog standard] log:@"Audio Session Interruption case ended."];
			_isInterruption = NO;
			break;
		default:
			[[FileLog standard] log:@"Audio Session Interruption Notification case default: %d", interuptionType];
			break;
	}
}

#pragma mark - SingleSongPlayerDelegate
- (void)singleSongPlayerDidPlay {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithUnsignedInteger:MiaPlayerEventDidPlay], MusicMgrNotificationKey_PlayerEvent,
							  self.currentItem.mid ? self.currentItem.mid : kDefaultMusicID, MusicMgrNotificationKey_MusicID,
							  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:MusicMgrNotificationPlayerEvent object:self userInfo:userInfo];
}

- (void)singleSongPlayerDidPause {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithUnsignedInteger:MiaPlayerEventDidPause], MusicMgrNotificationKey_PlayerEvent,
							  self.currentItem.mid ? self.currentItem.mid : kDefaultMusicID, MusicMgrNotificationKey_MusicID,
							  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:MusicMgrNotificationPlayerEvent object:self userInfo:userInfo];
}

- (void)singleSongPlayerDidCompletion {
	[self playNext];
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithUnsignedInteger:MiaPlayerEventDidCompletion], MusicMgrNotificationKey_PlayerEvent,
							  self.currentItem.mid ? self.currentItem.mid : kDefaultMusicID, MusicMgrNotificationKey_MusicID,
							  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:MusicMgrNotificationPlayerEvent object:self userInfo:userInfo];
}

- (void)singleSongPlayerDidBufferStream {
	[self bs_performBlock:^{
		NSLog(@"delayPreloader");
		if (_playList.count > 0) {
			HXSongModel *nextItem = _playList[[self getNextIndex]];
			[_preloader preloadWithItem:nextItem];
		}
	} afterDelay:30.0f];
}

- (void)singleSongPlayerDidFailure {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithUnsignedInteger:MiaPlayerEventDidPause], MusicMgrNotificationKey_PlayerEvent,
							  self.currentItem.mid ? self.currentItem.mid : kDefaultMusicID, MusicMgrNotificationKey_MusicID,
							  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:MusicMgrNotificationPlayerEvent object:self userInfo:userInfo];
}

#pragma mark - SongPreloaderDelegate
- (BOOL)songPreloaderIsPlayerLoadedThisUrl:(NSString *)url {
	return [_player.currentItem.mp3Url isEqualToString:url];
}

@end






