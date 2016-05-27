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

/**
 *  检测下载歌曲的缓存大小
 *
 *  @param completeBlock completeBlock
 */
+ (void)checkSongCacheSizeWithCompleteBlock:(void (^)(unsigned long long cacheSize))completeBlock;
/**
 *  删除下载的歌曲.
 *
 *  @param completeBlock completeBlock
 */
+ (void)cleanSongCacheWithCompleteBlock:(void (^)())completeBlock;

@end
