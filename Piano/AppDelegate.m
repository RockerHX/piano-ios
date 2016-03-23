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
#import "MobClick.h"
#import "HXVersion.h"

// Share SDK
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "WXApi.h"
//#import "WeiboSDK.h"


@interface AppDelegate ()
@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
#pragma mark - UMeng Analytics SDK
    // 设置版本号
    [MobClick setAppVersion:[[HXVersion appVersion] stringByAppendingFormat:@"(%@)", [HXVersion appBuildVersion]]];
    [MobClick setEncryptEnabled:YES];       // 日志加密
    // 启动[友盟统计]
    [MobClick setCrashReportEnabled:NO];
    
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:@"com.miamusic.ios"]) {
        [MobClick startWithAppkey:UMengAPPKEY reportPolicy:BATCH channelId:@"appstore"];
    } else {
        [MobClick startWithAppkey:UMengAPPKEY reportPolicy:BATCH channelId:@"fir.im"];
    }
    
//#pragma mark - Testin Crash SDK
//    [TestinAgent init:TestinAPPKEY channel:FirimChannel config:[TestinConfig defaultConfig]];
    
#pragma mark - Share SDK
    NSArray *activePlatforms = @[@(SSDKPlatformTypeWechat),
                                 @(SSDKPlatformTypeSMS)/*,
                                                        @(SSDKPlatformTypeMail),
                                                        @(SSDKPlatformTypeSinaWeibo)*/];
    [ShareSDK registerApp:ShareSDKKEY activePlatforms:activePlatforms onImport:^(SSDKPlatformType platformType) {
        switch (platformType) {
            case SSDKPlatformTypeWechat: {
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            }
//            case SSDKPlatformTypeSinaWeibo: {
//                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                break;
//            }
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
//            case SSDKPlatformTypeSinaWeibo: {
//                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
//                appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
//                redirectUri:@"http://www.sharesdk.cn"
//                authType:SSDKAuthTypeBoth];
//                break;
//            }
            default:
                break;
        }
    }];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
