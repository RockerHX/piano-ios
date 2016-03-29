//
//  WebSocketMgr.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import "MiaRequestItem.h"

//typedef void(^RequestGetBannerSceneSuccess)();

extern NSString * const WebSocketMgrNotificationKey_Msg;
extern NSString * const WebSocketMgrNotificationKey_Command;
extern NSString * const WebSocketMgrNotificationKey_Values;

extern NSString * const WebSocketMgrNotificationDidOpen;
extern NSString * const WebSocketMgrNotificationDidFailWithError;
extern NSString * const WebSocketMgrNotificationDidAutoReconnectFailed;
extern NSString * const WebSocketMgrNotificationDidCloseWithCode;
extern NSString * const WebSocketMgrNotificationDidReceivePong;

extern NSString * const WebSocketMgrNotificationPushUnread;
extern NSString * const WebSocketMgrNotificationPushRoomEnter;
extern NSString * const WebSocketMgrNotificationPushRoomComment;

extern NSString * const NetworkNotificationKey_Status;
extern NSString * const NetworkNotificationReachabilityStatusChange;


@interface WebSocketMgr : NSObject

/**
 *  使用单例初始化
 *
 */
+(id)standard;

- (void)watchNetworkStatus;

- (BOOL)isNetworkEnable;
- (BOOL)isWifiNetwork;

/**
 *  判断长连接状态是否等于SR_OPEN
 *  注意isOpen和isClose不是是非关系，因为中间还有两个过程状态
 *  SR_CONNECTING, SR_OPEN, SR_CLOSING, SR_CLOSED
 *
 *  @return 长连接已经打开了，而不是连接中或者关闭，关闭中
 */
- (BOOL)isOpen;

/**
 *  判断长连接状态是否等于SR_CLOSED
 *  注意isOpen和isClose不是是非关系，因为中间还有两个过程状态
 *  SR_CONNECTING, SR_OPEN, SR_CLOSING, SR_CLOSED
 *
 *  @return 长连接已经关闭了，而不是正在关闭或者连接中，打开
 */
- (BOOL)isClosed;

- (void)reconnect;
- (void)close;
- (void)sendPing:(id)sender;
- (void)send:(id)data;

- (void)sendWitRequestItem:(MiaRequestItem *)requestItem;

@end
