//
//  AppDelegate.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "AppDelegate.h"
#import "HXAppConstants.h"

// UMeng SDK
#import <UMMobClick/MobClick.h>
#import <UMengSocialCOM/UMSocial.h>
#import <UMengSocialCOM/UMSocialWechatHandler.h>
#import <UMengSocialCOM/UMSocialSinaSSOHandler.h>
#import "HXVersion.h"

// MusicMgr
#import "UserSetting.h"
#import "WebSocketMgr.h"
#import "BlocksKit+UIKit.h"
#import "MusicMgr.h"
#import "JPUSHService.h"
#import "NSString+IsNull.h"

#import "HXWatchLiveLandscapeViewController.h"

@interface AppDelegate ()
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
	//启用远程控制事件接收
	[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	// 默认用户配置
	[UserSetting registerUserDefaults];

#pragma mark - UMeng Analytics SDK
    // 设置版本号
    [MobClick setAppVersion:[[HXVersion appVersion] stringByAppendingFormat:@"(%@)", [HXVersion appBuildVersion]]];
    [MobClick setEncryptEnabled:YES];       // 日志加密
    // 启动[友盟统计]
    [MobClick setCrashReportEnabled:YES];
    
    UMAnalyticsConfig *analyticsConfigure = [UMAnalyticsConfig sharedInstance];
    analyticsConfigure.appKey = UMengAPPKEY;
    analyticsConfigure.ePolicy = BATCH;
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:APPSTORE_BUNDLE_ID]) {
        analyticsConfigure.channelId = CHANNEL_APPSTORE;
    } else {
        analyticsConfigure.channelId = CHANNEL_FIRIM;
    }
    [MobClick startWithConfigure:analyticsConfigure];
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMengAPPKEY];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeiXinKEY appSecret:WeiXinSecret url:@"http://www.baidu.com"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 UMSocialSinaSSOHandler.h
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WeiBoKEY
                                              secret:WeiBoSecret
                                         RedirectURL:WeiBoRedirectUri];
    
//#pragma mark - Testin Crash SDK
//    [TestinAgent init:TestinAPPKEY channel:FirimChannel config:[TestinConfig defaultConfig]];

#pragma mark - JPush SDK
	//Required
	if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
		//       categories
		[JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
														  UIUserNotificationTypeSound |
														  UIUserNotificationTypeAlert)
											  categories:nil];
	} else {
		//categories    nil
//		[JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//														  UIRemoteNotificationTypeSound |
//														  UIRemoteNotificationTypeAlert)
//											  categories:nil];
	}
	
	//Required
	if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:APPSTORE_BUNDLE_ID]) {
		[JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY_APPSTORE channel:CHANNEL_APPSTORE apsForProduction:YES];
	} else {
		[JPUSHService setupWithOption:launchOptions appKey:JPUSH_APPKEY_ENTERPRISE channel:CHANNEL_FIRIM apsForProduction:YES];
	}

	NSDictionary *remoteNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsRemoteNotificationKey];
	if (remoteNotification) {
		[self handleNotification:remoteNotification];
	}
    
	return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {}

- (void)applicationDidEnterBackground:(UIApplication *)application {}

- (void)applicationWillEnterForeground:(UIApplication *)application {}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// 切换回前台主动取消被打断状态
	[MusicMgr standard].isInterruption = NO;

	[JPUSHService resetBadge];
	[application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == NO) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}

#pragma mark - 远程控制事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
	NSDictionary *userInfo = [NSDictionary dictionaryWithObject:event forKey:MusicMgrNotificationKey_RemoteControlEvent];
	[[NSNotificationCenter defaultCenter] postNotificationName:MusicMgrNotificationRemoteControlEvent object:self userInfo:userInfo];
}

#pragma mark - Notifications
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
	/// Required -    DeviceToken
	[JPUSHService registerDeviceToken:deviceToken];

	NSSet *tags = nil;
	NSString *alias = nil;

#ifdef DEBUG
	tags = [NSSet setWithObjects:@"develop", nil];
	alias = @"ios_develop";
#else
	tags = [NSSet setWithObjects:@"production", nil];
	alias = @"ios_production";
#endif

	[JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias){
		NSLog(@"JPUSH setTags rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, iTags, iAlias);
	}];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
	// IOS 7 Support Required
	if (application.applicationState == UIApplicationStateInactive) {
		[self handleNotification:userInfo];
	} else {
		NSLog(@"active or background, do nothing.");
	}

	[JPUSHService handleRemoteNotification:userInfo];
	completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	//Optional
	NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

static NSString * const PushExtraKey_Action					= @"action";
static NSString * const PushExtraKey_PARAM1					= @"param1";
static NSString * const PushExtraKey_PARAM2					= @"param2";
static NSString * const PushAction_WatchLive				= @"watchlive";

#pragma mark - handle notifications
- (void)handleNotification:(NSDictionary *)userInfo {
	NSString *action = userInfo[PushExtraKey_Action];
	NSString *param1 = userInfo[PushExtraKey_PARAM1];
	NSString *param2 = userInfo[PushExtraKey_PARAM2];
	if ([NSString isNull:action]
		|| [NSString isNull:param1]
		|| [NSString isNull:param2]) {
		return;
	}

    if ([action isEqualToString:PushAction_WatchLive]) {
        NSLog(@"%@ with roomID: %@", action, param1);
        BOOL horizontal = [param2 boolValue];
        NSString *roomID = param1;
		if ([[WebSocketMgr standard] isWifiNetwork] || [UserSetting playWith3G]) {
			[self showLive:horizontal roomID:roomID];
		} else {
			[UIAlertView bk_showAlertViewWithTitle:k3GPlayTitle message:k3GPlayMessage cancelButtonTitle:k3GPlayCancel otherButtonTitles:@[k3GPlayAllow] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
				if (buttonIndex != alertView.cancelButtonIndex) {
					[self showLive:horizontal roomID:roomID];
				}
			}];
		}
	}
}

- (void)showLive:(BOOL)horizontal roomID:(NSString *)roomID {
    UINavigationController *watchLiveNavigationController = nil;
    if (horizontal) {
        watchLiveNavigationController = [HXWatchLiveLandscapeViewController navigationControllerInstance];
    } else {
        watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
    }
    HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];;
    watchLiveViewController.roomID = roomID;
    [self.window.rootViewController presentViewController:watchLiveNavigationController animated:YES completion:nil];
}

@end
