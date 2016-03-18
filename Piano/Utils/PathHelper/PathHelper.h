//
//  PathHelper.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface PathHelper : NSObject

+ (NSString *)cacheDir;

/**
 *  播放器缓存目录
 *
 */
+ (NSString *)playCacheDir;

/**
 *  收藏歌曲的本地下载目录
 *
 */
+ (NSString *)favoriteCacheDir;

+ (NSString *)userDir;

/**
 *  以UID为目录名的用户目录
 *
 *  @param uid 用户ID，为nil时用0替代
 *
 */
+ (NSString *)userDirWithUID:(NSString *)uid;

+ (NSString *)logDir;

/**
 *  分享列表的本地缓存文件路径
 *
 */
+ (NSString *)shareArchivePathWithUID:(NSString *)uid;

/**
 *  收藏列表的本地缓存文件路径
 *
 *  @param uid 用户ID，为nil时用0替代
 *
 */
+ (NSString *)favoriteArchivePathWithUID:(NSString *)uid;

+ (NSString *)playlistArchivePathWithUID:(NSString *)uid;

+ (NSString *)genMusicFilenameWithUrl:(NSString *)url;

+ (NSString *)logFileName;

@end
