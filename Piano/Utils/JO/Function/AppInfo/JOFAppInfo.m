//
//  JOFAppInfo.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/12.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFAppInfo.h"

@implementation JOFAppInfo

+ (NSString *)appVersion{
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion{

    return  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)appName{

    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

@end
