//
//  JOFLog.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOFLog : JOFunctionObject

/**
 *  创建一个JOFLog的对象.
 *
 *  @return 返回创建的这个JOFLog对象. 默认给定了一个Log文件的名字.
 */
+ (JOFLog *)log;

/**
 *  根据名字创建一个JOFLog的对象.
 *
 *  @param fileName Log文件的名字
 *
 *  @return 返回创建的这个JOFLog对象.
 */
+ (JOFLog *)logWithFileName:(NSString *)fileName;

/**
 *  初始化方法.
 *
 *  @param fileName Log文件的名字.
 *
 *  @return 返回创建的这个JOFLog对象.
 */
- (instancetype)initWithLogFileName:(NSString *)fileName;

/**
 *  将Log写入到文件中.
 *
 *  @param contextString 需要写入的内容.
 *  @param yesOrNo       是否在写入之前清空原来的里面的内容: yes 清空 no 保留
 */
- (void)writeLogToFileWithContextString:(NSString *)contextString clean:(BOOL)yesOrNo;

/**
 *  @see - writeLogToFileWithContextString:clean:.
 *
 *  默认clean为no.
 */
- (void)writeLogToFileWithContextString:(NSString *)contextString;

/**
 *  清空Log的日志.
 */
- (void)cleanLog;

/**
 *  获取log文件的路径.
 *
 *  @return log文件的路径.
 */
- (NSString *)logFilePath;

@end
