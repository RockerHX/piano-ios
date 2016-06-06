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
#import "HXVersion.h"

// Share SDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
#import "WeiboSDK.h"

// MusicMgr
#import "UserSetting.h"
#import "MusicMgr.h"
#import "JPUSHService.h"
#import "NSString+IsNull.h"

#import "HXWatchLiveViewController.h"

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
    [MobClick setCrashReportEnabled:NO];
    
    UMAnalyticsConfig *analyticsConfigure = [UMAnalyticsConfig sharedInstance];
    analyticsConfigure.appKey = UMengAPPKEY;
    analyticsConfigure.ePolicy = BATCH;
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:APPSTORE_BUNDLE_ID]) {
        analyticsConfigure.channelId = CHANNEL_APPSTORE;
    } else {
        analyticsConfigure.channelId = CHANNEL_FIRIM;
    }
    [MobClick startWithConfigure:analyticsConfigure];
    
//#pragma mark - Testin Crash SDK
//    [TestinAgent init:TestinAPPKEY channel:FirimChannel config:[TestinConfig defaultConfig]];
    
#pragma mark - Share SDK
    NSArray *activePlatforms = @[@(SSDKPlatformTypeWechat),
                                 @(SSDKPlatformTypeSinaWeibo)];
    [ShareSDK registerApp:ShareSDKKEY activePlatforms:activePlatforms onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeWechat: {
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            }
            case SSDKPlatformTypeSinaWeibo: {
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            }
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeWechat: {
                [appInfo SSDKSetupWeChatByAppId:WeiXinKEY
                                      appSecret:WeiXinSecret];
                break;
            }
            case SSDKPlatformTypeSinaWeibo: {
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:WeiBoKEY
                                          appSecret:WeiBoSecret
                                        redirectUri:WeiBoRedirectUri
                                           authType:SSDKAuthTypeBoth];
                break;
            }
            default:
                break;
        }
    }];

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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

	// 切换回前台主动取消被打断状态
	[MusicMgr standard].isInterruption = NO;

	// 设置后台播放模式
	AVAudioSession *audioSession=[AVAudioSession sharedInstance];
	[audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
	[audioSession setActive:YES error:nil];

	[JPUSHService resetBadge];
	[application setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
static NSString * const PushAction_WatchLive				= @"watchlive";

#pragma mark - handle notifications
- (void)handleNotification:(NSDictionary *)userInfo {
	NSString *action = userInfo[PushExtraKey_Action];
	NSString *param1 = userInfo[PushExtraKey_PARAM1];
	if ([NSString isNull:action] || [NSString isNull:param1]) {
		return;
	}

	if ([action isEqualToString:PushAction_WatchLive]) {
		NSLog(@"%@ with roomID: %@", action, param1);

		UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
		HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
		watchLiveViewController.roomID = param1;
		[self.window.rootViewController presentViewController:watchLiveNavigationController animated:YES completion:nil];

	}
}

@end
