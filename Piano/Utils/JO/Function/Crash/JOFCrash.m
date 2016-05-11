//
//  JOFCrash.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFCrash.h"
#import "JOFLog.h"

static NSString *const kCrashFileName = @"DefaultCrash.log";

@implementation JOFCrash

void uncaughtExceptionHandler(NSException *exception){

    // 异常的堆栈信息
    NSArray *stackArray = [exception callStackSymbols];
    // 出现异常的原因
    NSString *reason = [exception reason];
    // 异常名称
    NSString *name = [exception name];
    NSString *exceptionInfo = [NSString stringWithFormat:@"Exception reason：%@\nException name：%@\nException stack：%@\n\n",name, reason, stackArray];
    //    NSLog(@"%@", exceptionInfo);
    
    [[JOFLog logWithFileName:kCrashFileName] writeLogToFileWithContextString:exceptionInfo];
}

+ (void)openCrashLogEnable:(BOOL)enable{

    if (enable) {
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    }
}

+ (void)cleanCrashLog{

    [[JOFLog logWithFileName:kCrashFileName] cleanLog];
}

+ (NSString *)crashLogPath{

   return [[JOFLog logWithFileName:kCrashFileName] logFilePath];
}

@end
