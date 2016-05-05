//
//  JOFCrash.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOFCrash : JOFunctionObject

/**
 *  用户捕获crash的日志.
 *
 *  @param exception crash的异常.
 */
JO_STATIC_INLINE void uncaughtExceptionHandler(NSException *exception);

/**
 *  是否开启将crash的日志写入到日志的文件.
 *
 *  @param enable 开启的状态.
 */
+ (void)openCrashLogEnable:(BOOL)enable;

/**
 *  清空crash的日志.
 */
+ (void)cleanCrashLog;

/**
 *  crash的日志文件的路径.
 *
 *  @return 日志文件的路径.
 */
+ (NSString *)crashLogPath;

@end
