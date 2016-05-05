//
//  JOFException.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOFException : JOFunctionObject

/**
 *  创建并抛出一个异常,在某些条件下把异常写入到一个异常的文件中.
 *
 *  @param exceptionName 异常的名字.
 *  @param reason        异常的理由.
 *  @param yesOrNo       是否保存到文件: yes 保存 no 不保存
 */
+ (void)exceptionWithName:(NSString *)exceptionName reason:(NSString *)reason saveState:(BOOL)yesOrNo;

/**
 *  默认不保存到异常文件中.
 *
 *  @see - exceptionWithName:reason:saveState:
 *
 */
+ (void)exceptionWithName:(NSString *)exceptionName reason:(NSString *)reason;

#pragma mark - 生成一个异常并抛出该异常.

/**
 *  抛出一个异常.
 *
 *  @param exceptionName 异常的名字.
 *  @param reason        异常的理由.
 */
+ (void)raiseExceptionWithName:(NSString *)exceptionName reason:(NSString *)reason;

/**
 *  抛出一个理由为空的异常.
 *
 *  @see - raiseExceptionWithName:reason:
 */
+ (void)raiseExceptionWithName:(NSString *)exceptionName;

#pragma mark - 生成一个异常.

/**
 *  生成一个异常.
 *
 *  @param exceptionName 异常的名字.
 *  @param reason        异常的理由.
 *  @param userInfo      异常的一些信息.
 *
 *  @return NSException.
 */
+ (NSException *)createExceptionWithName:(NSString *)exceptionName
                                  reason:(NSString *)reason
                                userInfo:(NSDictionary *)userInfo;

/**
 *  userInfo 为nil.
 *
 *  @see -  createExceptionWithName:reason:userInfo:
 */
+ (NSException *)createExceptionWithName:(NSString *)exceptionName reason:(NSString *)reason;

/**
 *  userInfo 为nil. reason 为@"".
 *
 *  @see -  createExceptionWithName:reason:userInfo:
 */
+ (NSException *)createExceptionWithName:(NSString *)exceptionName;

@end
