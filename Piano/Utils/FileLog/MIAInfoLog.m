//
//  MIAInfoLog.m
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAInfoLog.h"
#import "MiaAPIHelper.h"
#import "JOBaseSDK.h"
#import "HXAlertBanner.h"
#import "HXUserSession.h"

@implementation MIAInfoLog

+ (void)uploadInfoLogWithRoomID:(NSString *)roomID streamID:(NSString *)streamID{

    NSString *versionString = [NSString stringWithFormat:@"%@.%@",[JOFAppInfo appVersion],[JOFAppInfo appBuildVersion]];
    NSString *deviceString = [JOFDeviceInfo deviceName];
    NSString *systemVersion = [NSString stringWithFormat:@"%.2f",[JOFDeviceInfo currentSystemVersion]];
    NSString *userName = [[[HXUserSession session] user] nickName];
	NSString *userID = [HXUserSession session].uid;
    
    NSString *contentString = [NSString stringWithFormat:@"iOS 昵称:%@ 设备:%@ 系统版本:%@ APP版本:%@ userID:%@ roomID:%@ streamID:%@",
							   userName,
							   deviceString,
							   systemVersion,
							   versionString,
							   userID,
							   JOConvertStringToNormalString(roomID),
							   JOConvertStringToNormalString(streamID)];
    
    [MiaAPIHelper uploadLogWithRoomID:JOConvertStringToNormalString(roomID)
                              content:contentString
                               fileID:@""
                        completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                            
                            if (success) {
                                JOLog(@"上报直播卡顿成功");
                                [HXAlertBanner showWithMessage:@"上报直播卡顿成功" tap:nil];
                            }else{
                                JOLog(@"上报直播卡顿失败");
                                [HXAlertBanner showWithMessage:@"上报直播卡顿失败" tap:nil];
                            }
                        }timeoutBlock:^(MiaRequestItem *requestItem) {
                             
                         }];
}

@end
