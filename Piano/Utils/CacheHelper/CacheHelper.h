//
//  CacheHelper.h
//
//
//  Created by linyehui on 2015/11/02.
//  Copyright (c) 2015年 linyehui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheHelper : NSObject

+ (void)checkCacheSizeWithCompleteBlock:(void (^)(unsigned long long cacheSize))completeBlock;

+ (void)cleanCacheWithCompleteBlock:(void (^)())completeBlock;

@end
