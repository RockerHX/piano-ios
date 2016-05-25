//
//  MIAFileDownloadManage.h
//  Piano
//
//  Created by 刘维 on 16/5/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kMIASongDownloadFinishedNoticeKey; //一首歌下载完成后给出的通知名
extern NSString *const kMIASongDownloadNoticeURLKey;//通知中userinfo中URL string对应的key值

@interface MIASongManage : NSObject

+ (MIASongManage *)shareSongManage;

/**
 *  开始下载多个文件.
 *
 *  @param urlArray 需要下载文件的URL数组.
 */
- (void)startDownloadSongWithURLArray:(NSArray *)urlArray;

/**
 *  开始下载一个文件.
 *
 *  @param urlString 下载文件的URL.
 */
- (void)startDownloadSongWithURLString:(NSString *)urlString;

/**
 *  歌曲文件夹的路径.
 *
 *  @return 文件夹的路径.
 */
- (NSString *)songFilePath;

/**
 *  歌曲是否已经在本地存在.
 *
 *  @param urlString 歌曲的URL的字符串
 *
 *  @return 本地存在的状态.
 */
- (BOOL)songIsExistWithURLString:(NSString *)urlString;

/**
 *  删除所有的本地歌曲
 */
- (void)cleanAllSongFileWithCompleteBlock:(void (^)())completeBlock;

/**
 *  歌曲在本地的路径.
 *
 *  @param URLString 歌曲的URL的字符串
 *
 *  @return 本地的路径,如果不存在则返回@""的字符串.
 */
- (NSString *)songPathWithURLString:(NSString *)URLString;

@end
