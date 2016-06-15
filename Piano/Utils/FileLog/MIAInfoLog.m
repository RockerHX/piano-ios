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

    NSString *versionString = [NSString stringWithFormat:@"V%@.%@",[JOFAppInfo appVersion],[JOFAppInfo appBuildVersion]];
    NSString *deviceString = [JOFDeviceInfo deviceName];
    NSString *systemVersion = [NSString stringWithFormat:@"%.2f",[JOFDeviceInfo currentSystemVersion]];
    NSString *userName = [[[HXUserSession session] user] nickName];
    
    NSString *contentString = [NSString stringWithFormat:@"昵称:%@ 设备:%@ 系统版本:%@ app版本号:%@ StreamID:%@",userName,deviceString,systemVersion,versionString,JOConvertStringToNormalString(streamID)];
    
    [MiaAPIHelper uploadLogWithRoomID:JOConvertStringToNormalString(roomID)
                              content:contentString
                               fileID:@""
                        completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                            
                            if (success) {
                                JOLog(@"日志提交成功");
                                [HXAlertBanner showWithMessage:@"日志提交成功" tap:nil];
                            }else{
                                JOLog(@"日志提交失败");
                                [HXAlertBanner showWithMessage:@"日志提交失败" tap:nil];
                            }
                        }timeoutBlock:^(MiaRequestItem *requestItem) {
                             
                         }];
}

@end
