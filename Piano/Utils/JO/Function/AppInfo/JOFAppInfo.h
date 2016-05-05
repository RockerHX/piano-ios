//
//  JOFAppInfo.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/12.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFunctionObject.h"

@interface JOFAppInfo : JOFunctionObject

/**
 *  应用的版本号.
 *
 *  @return 返回应用当前设置的版本号.
 */
+ (NSString *)appVersion;

/**
 *  应用bulid的版本号.
 *
 *  @return app build的版本号,自己定义的.若app提交到了itunesContent之后,你又想重新提交一个新的到里面去,
 *  只需要两个build版本不同即可,否则只能更改版本号,不然会提交失败.
 */
+ (NSString *)appBuildVersion;

/**
 *  应用的名字.
 *
 *  @return 应用的名字.
 */
+ (NSString *)appName;

@end
