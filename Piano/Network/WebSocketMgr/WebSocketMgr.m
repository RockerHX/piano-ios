//
//  WebSocketMgr.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import "WebSocketMgr.h"
#import "SRWebSocket.h"
#import "MiaAPIHelper.h"
#import "AFNetworking.h"
#import "NSTimer+BlockSupport.h"
#import "MiaAPIMacro.h"
#import "FileLog.h"

NSString * const WebSocketMgrNotificationKey_Msg					= @"msg";
NSString * const WebSocketMgrNotificationKey_Command				= @"cmd";
NSString * const WebSocketMgrNotificationKey_Values					= @"values";

NSString * const WebSocketMgrNotificationDidOpen			 		= @"WebSocketMgrNotificationDidOpen";
NSString * const WebSocketMgrNotificationDidFailWithError			= @"WebSocketMgrNotificationDidFailWithError";
NSString * const WebSocketMgrNotificationDidAutoReconnectFailed		= @"WebSocketMgrNotificationDidAutoReconnectFailed";
NSString * const WebSocketMgrNotificationDidCloseWithCode			= @"WebSocketMgrNotificationDidCloseWithCode";
NSString * const WebSocketMgrNotificationDidReceivePong				= @"WebSocketMgrNotificationDidReceivePong";

NSString * const WebSocketMgrNotificationPushUnread					= @"WebSocketMgrNotificationPushUnread";
NSString * const WebSocketMgrNotificationPushRoomEnter				= @"WebSocketMgrNotificationPushRoomEnter";
NSString * const WebSocketMgrNotificationPushRoomClose				= @"WebSocketMgrNotificationPushRoomClose";
NSString * const WebSocketMgrNotificationPushRoomAttention			= @"WebSocketMgrNotificationPushRoomAttention";
NSString * const WebSocketMgrNotificationPushRoomShare              = @"WebSocketMgrNotificationPushRoomShare";
NSString * const WebSocketMgrNotificationPushRoomGift               = @"WebSocketMgrNotificationPushRoomGift";
NSString * const WebSocketMgrNotificationPushRoomReward             = @"WebSocketMgrNotificationPushRoomReward";
NSString * const WebSocketMgrNotificationPushRoomComment			= @"WebSocketMgrNotificationPushRoomComment";


NSString * const NetworkNotificationKey_Status						= @"status";
NSString * const NetworkNotificationReachabilityStatusChange		= @"NetworkNotificationReachabilityStatusChange";

const static NSTimeInterval kAutoReconnectTimeout_First				= 5.0;
const static NSTimeInterval kAutoReconnectTimeout_Second			= 15.0;
const static NSTimeInterval kAutoReconnectTimeout_Loop				= 30.0;

@interface WebSocketMgr() <SRWebSocketDelegate>

@end

@implementation WebSocketMgr{
	SRWebSocket 				*_webSocket;
	BOOL						_firstConnect;
	NSTimer 					*_timer;
	AFNetworkReachabilityStatus _networkStatus;

	NSMutableDictionary			*_requestData;
	dispatch_queue_t 			_requestDataSyncQueue;

	unsigned long				_retryTimes;
	NSTimer 					*_firstAutoReconnectTimer;
	NSTimer 					*_secondAutoReconnectTimer;
	NSTimer 					*_loopAutoReconnectTimer;	// 网络是好的，但是我们的服务器连不上，这时需要一个定时器一起检查
}

/**
 *  使用单例初始化
 *
 */
+ (id)standard{
    static WebSocketMgr *webSocketMgr = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        webSocketMgr = [[self alloc] init];
    });
    return webSocketMgr;
}

- (instancetype)init {
	if (self = [super init]) {
		_firstConnect = YES;
		_requestData = [[NSMutableDictionary alloc] init];
		_requestDataSyncQueue = dispatch_queue_create("com.miamusic.requestarraysyncqueue", NULL);
	}

	return self;

}
- (void)watchNetworkStatus {
	_networkStatus = AFNetworkReachabilityStatusUnknown;
	
	[[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:
	 ^(AFNetworkReachabilityStatus status) {
		 [[FileLog standard] log:@"Network status change: %ld", (long)status];

		_networkStatus = status;
		 NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
								   [NSNumber numberWithInteger:status], NetworkNotificationKey_Status,
								   nil];
		 [[NSNotificationCenter defaultCenter] postNotificationName:NetworkNotificationReachabilityStatusChange object:self userInfo:userInfo];

		 // 判断是否需要断线重连，第一次启动也直接走断线重连流程
		 if ([self isNetworkEnable]) {
			 if ([self isClosed]) {
				 [self autoReconnect];
			 }
		 } else {
			 [[FileLog standard] log:@"Network is broken, stopAutoReconnect"];
			 [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidAutoReconnectFailed object:self];
			 [self stopAutoReconnect];
		 }
	}];
	[[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (BOOL)isNetworkEnable {
	if (_networkStatus == AFNetworkReachabilityStatusReachableViaWWAN
		|| _networkStatus == AFNetworkReachabilityStatusReachableViaWiFi) {
		return YES;
	}

	return NO;
}

- (BOOL)isWifiNetwork {
	return (_networkStatus == AFNetworkReachabilityStatusReachableViaWiFi);
}

- (BOOL)isOpen {
	if ([_webSocket readyState] == SR_OPEN) {
		return YES;
	}

	return NO;
}

- (BOOL)isClosed {
	if (!_webSocket)
		return YES;

	if ([_webSocket readyState] == SR_CLOSED) {
		return YES;
	}

	return NO;
}

- (void)reconnect {
	_webSocket.delegate = nil;
	[_webSocket close];

#ifdef DEBUG
	static NSString * const kMIAAPIUrl = @"wss://ws-piano-test.miamusic.com:443";
#else
	static NSString * const kMIAAPIUrl = @"wss://ws-piano.miamusic.com:443";
#endif

	_webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kMIAAPIUrl]]];
	_webSocket.delegate = self;

	NSLog(@"WebSocket opening");
	[_webSocket open];
	
}

- (void)close {
	NSLog(@"WebSocket closing");
	_firstConnect = NO;
	[_timer invalidate];

	_webSocket.delegate = nil;
	[_webSocket close];
	_webSocket = nil;
}

- (void)sendPing:(id)sender {
	if (![self isOpen]) {
		NSLog(@"sendPing failed, websocket is not opening!");
		return;
	}

	[_webSocket sendPing:nil];
}

- (void)send:(id)data {
	if (![self isOpen]) {
		NSLog(@"send failed, websocket is not opening!");
		return;
	}

	[_webSocket send:data];
}

- (void)sendWitRequestItem:(MiaRequestItem *)requestItem {
	const static int64_t kRequestTimeout = 10;

	// 长连接没打开的时候直接返回超时，不用尝试
	if (![self isOpen]) {
		NSLog(@"WebSocket is closed, ignore sendWitRequestItem:%@", requestItem.command);
		if ([requestItem timeoutBlock]) {
			[requestItem timeoutBlock](requestItem);
		}

		return;
	}

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		// 使用GDC同步锁保证读写同步
		dispatch_sync(_requestDataSyncQueue, ^{
			// 这里不考虑时间戳相同的情况
			[_requestData setObject:requestItem forKey:[NSNumber numberWithLong:[requestItem timestamp]]];
//			NSLog(@"#WebSocketWithBlock# BEGIN %ld %@", [requestItem timestamp], [requestItem command]);
		});

		// 超时检测
		dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, kRequestTimeout * NSEC_PER_SEC);
		dispatch_after(delayTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
			// 使用GDC同步锁保证读写同步
			dispatch_sync(_requestDataSyncQueue, ^{
				MiaRequestItem *lastItem = [_requestData objectForKey:[NSNumber numberWithLong:[requestItem timestamp]]];
				if (lastItem) {
					// 超时了
					[[FileLog standard] log:@"#WebSocketWithBlock# TMOUT %ld\n%@", [requestItem timestamp], [requestItem jsonString]];
					
					dispatch_sync(dispatch_get_main_queue(), ^{
						if ([requestItem timeoutBlock]) {
							[requestItem timeoutBlock](requestItem);
						}
					});
					[_requestData removeObjectForKey:[NSNumber numberWithLong:[requestItem timestamp]]];
				}
			});
		});

		dispatch_sync(dispatch_get_main_queue(), ^{
			[self send:[requestItem jsonString]];
		});

	});
}

- (BOOL)isAutoReconnecting {
	return (_retryTimes > 0);
}
- (void)autoReconnect {
	[[FileLog standard] log:@"auto reconnect, retry times: %ld", _retryTimes];
	_retryTimes++;
	[self reconnect];
}

- (void)stopAutoReconnect {
	_retryTimes = 0;

	[_firstAutoReconnectTimer invalidate];
	[_secondAutoReconnectTimer invalidate];
	[_loopAutoReconnectTimer invalidate];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
	_firstConnect = NO;
	[self stopAutoReconnect];

	// 心跳的定时发送时间间隔
	static const NSTimeInterval kWebSocketPingTimeInterval = 30;

	[[FileLog standard] log:@"Websocket Connected"];
	_timer = [NSTimer scheduledTimerWithTimeInterval:kWebSocketPingTimeInterval
											 target:self
										   selector:@selector(pingTimerAction)
										   userInfo:nil
											repeats:YES];

	[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidOpen object:self];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
	[[FileLog standard] log:@":( Websocket Failed With Error %@", error];
	// 应用启动后的第一次连接失败，直接跳转无网络页面
	if (_firstConnect) {
		[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidAutoReconnectFailed object:self];
	}

	_firstConnect = NO;
	[_timer invalidate];
	_webSocket = nil;

	if (![self isNetworkEnable]) {
		[[FileLog standard] log:@"Network is broken, ignore auto reconnect operations"];
		return;
	}

	if (_retryTimes == 0) {
		// 第一次连接失败，出发断线重连逻辑
		[self autoReconnect];
	} else if (_retryTimes == 1) {
		[_firstAutoReconnectTimer invalidate];

		// 网络波动的话，准备定时重连的时候再通知界面
		NSDictionary *userInfo = [NSDictionary dictionaryWithObject:error forKey:WebSocketMgrNotificationKey_Msg];
		[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidFailWithError object:self userInfo:userInfo];

		_firstAutoReconnectTimer = [NSTimer bs_scheduledTimerWithTimeInterval:kAutoReconnectTimeout_First block:
									^{
										// 第一次超时操作
										[self autoReconnect];
									} repeats:NO];
	} else if (_retryTimes == 2) {
		[_secondAutoReconnectTimer invalidate];
		_secondAutoReconnectTimer = [NSTimer bs_scheduledTimerWithTimeInterval:kAutoReconnectTimeout_Second block:
									^{
										// 第二次超时操作
										[self autoReconnect];
									} repeats:NO];
	} else {
		[_loopAutoReconnectTimer invalidate];
		_loopAutoReconnectTimer = [NSTimer bs_scheduledTimerWithTimeInterval:kAutoReconnectTimeout_Loop block:
									 ^{
										 // 第三次超时操作
										 [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidAutoReconnectFailed object:self];
										 // 网络是好的，但是我们的服务器连不上，这时定时器不停继续重连
										 [self autoReconnect];
									 } repeats:NO];
	}
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
	//NSLog(@"WebSocket Received:\n%@\n", message);

	//解析JSON
	NSError *error = nil;
	NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:[message dataUsingEncoding:NSUTF8StringEncoding]
													  options:NSJSONReadingMutableLeaves
														error:&error];
	if (error) {
		NSLog(@"websocket parse json error! dic->%@",error);
		return;
	}

	int ret = [userInfo[MiaAPIKey_Values][MiaAPIKey_Return] intValue];

	long timestamp = (long)[userInfo[MiaAPIKey_Timestamp] doubleValue];
	NSString *command = userInfo[MiaAPIKey_ServerCommand];
//	NSLog(@"#WebSocketWithBlock# E-N-D %@, %ld", command, timestamp);

	// Notification
	if ([command isEqualToString:MiaAPICommand_Push_UserNoti]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushUnread object:self userInfo:userInfo];
		return;
	} else if ([command isEqualToString:MiaAPICommand_Push_RoomEnter]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomEnter object:self userInfo:userInfo];
		return;
	} else if ([command isEqualToString:MiaAPICommand_Push_RoomClose]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomClose object:self userInfo:userInfo];
		return;
    } else if ([command isEqualToString:MiaAPICommand_Push_Attention]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomAttention object:self userInfo:userInfo];
        return;
    } else if ([command isEqualToString:MiaAPICommand_Push_Share]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomShare object:self userInfo:userInfo];
        return;
    } else if ([command isEqualToString:MiaAPICommand_Push_RoomGift]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomGift object:self userInfo:userInfo];
        return;
    } else if ([command isEqualToString:MiaAPICommand_Push_RoomReward]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomReward object:self userInfo:userInfo];
        return;
    } else if ([command isEqualToString:MiaAPICommand_Push_RoomComment]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationPushRoomComment object:self userInfo:userInfo];
        return;
    }

	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		// 使用GDC同步锁保证读写同步
		dispatch_sync(_requestDataSyncQueue, ^{
			MiaRequestItem *lastItem = [_requestData objectForKey:[NSNumber numberWithLong:timestamp]];
			if (lastItem) {
				dispatch_sync(dispatch_get_main_queue(), ^{
					if ([lastItem completeBlock]) {
						[lastItem completeBlock](lastItem, ret == 0, userInfo);
					}

					[_requestData removeObjectForKey:[NSNumber numberWithLong:[lastItem timestamp]]];
				});
			} else {
				NSLog(@"### WebSocket Timeout ### %@", command);
			}
		});
	});
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean {
	[[FileLog standard] log:@"WebSocket closed"];
	_firstConnect = NO;
	[_timer invalidate];
	_webSocket = nil;


	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
							  [NSNumber numberWithInteger:code], @"code",
							  reason, @"reason",
							  [NSNumber numberWithInteger:wasClean], @"wasClean",
							  nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidCloseWithCode object:self userInfo:userInfo];

	// 服务器主动断开连接，启动断线重连逻辑
	[self autoReconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(NSData *)pongPayload {
	[[NSNotificationCenter defaultCenter] postNotificationName:WebSocketMgrNotificationDidReceivePong object:self];
}

# pragma mark - Timer Action
-(void)pingTimerAction {
	[_webSocket sendPing:nil];
}

@end
















