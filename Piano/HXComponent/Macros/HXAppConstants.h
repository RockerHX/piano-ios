//
//  HXAppConstants.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Third SDK Key
FOUNDATION_EXPORT NSString *const UMengAPPKEY;              // 友盟SDK对应的APPKEY
FOUNDATION_EXPORT NSString *const TestinAPPKEY;             // Testin对应的GeneralKey
FOUNDATION_EXPORT NSString *const BaiDuMapKEY;              // 百度地图SDK对应的APPKEY
FOUNDATION_EXPORT NSString *const ShareSDKKEY;              // ShareSDK对应的APPKEY
FOUNDATION_EXPORT NSString *const WeiXinKEY;                // 微信SDK对应的AppID
FOUNDATION_EXPORT NSString *const WeiXinSecret;             // 微信SDK对应的AppSecret
FOUNDATION_EXPORT NSString *const WeiBoKEY;                 // 微博SDK对应的APPKEY

FOUNDATION_EXPORT NSString *const JPUSH_APPKEY;

FOUNDATION_EXPORT NSString *const APPSTORE_BUNDLE_ID;
FOUNDATION_EXPORT NSString *const CHANNEL_APPSTORE;
FOUNDATION_EXPORT NSString *const CHANNEL_FIRIM;

#pragma mark - Notification Name
FOUNDATION_EXPORT NSString *const HXApplicationDidBecomeActiveNotification;         // 程序从后台被唤起到前台的通知
FOUNDATION_EXPORT NSString *const HXMusicPlayerMgrDidPlayNotification;              // 通知专辑卡片改变播放状态的通知
FOUNDATION_EXPORT NSString *const HXMusicPlayerMgrDidPauseNotification;             // 通知专辑卡片改变暂停状态的通知
