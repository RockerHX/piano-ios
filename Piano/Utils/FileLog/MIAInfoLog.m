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

@implementation MIAInfoLog

+ (void)uploadInfoLogWithRoomID:(NSString *)roomID streamID:(NSString *)streamID{

    NSString *versionString = [NSString stringWithFormat:@"V%@.%@",[JOFAppInfo appVersion],[JOFAppInfo appBuildVersion]];
    NSString *deviceString = [JOFDeviceInfo deviceName];
    NSString *systemVersion = [NSString stringWithFormat:@"%.2f",[JOFDeviceInfo currentSystemVersion]];
    
    NSString *contentString = [NSString stringWithFormat:@"设备:%@  系统版本:%@ app版本号:%@ StreamID:%@",deviceString,systemVersion,versionString,JOConvertStringToNormalString(streamID)];
    
    [MiaAPIHelper uploadLogWithRoomID:JOConvertStringToNormalString(roomID)
                              content:contentString
                               fileID:@""
                        completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                            
                            if (success) {
//                                    NSLog(@"日志提交结果:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                                JOLog(@"日志提交成功");
                            }else{
                                
                                JOLog(@"日志提交失败");
                            }
                        }timeoutBlock:^(MiaRequestItem *requestItem) {
                             
                         }];
}

@end
