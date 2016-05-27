//
//  CacheHelper.m
//
//
//  Created by linyehui on 2015/11/02.
//  Copyright (c) 2015年 linyehui. All rights reserved.
//

#import "CacheHelper.h"
#import "SDWebImageManager.h"
#import "PathHelper.h"
#import "MIASongManage.h"

@implementation CacheHelper {
}

#pragma mark - Public Methods
+ (void)checkCacheSizeWithCompleteBlock:(void (^)(unsigned long long))completeBlock {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		unsigned long long totalSize = 0;

		NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
		totalSize += imageCacheSize;

		unsigned long long logDirSize = [self calcDiskSizeOfDir:[PathHelper logDir]];
		totalSize += logDirSize;

		unsigned long long playCacheDirSize = [self calcDiskSizeOfDir:[PathHelper playCacheDir]];
		totalSize += playCacheDirSize;

		dispatch_async(dispatch_get_main_queue(), ^{
			if (completeBlock) {
				completeBlock(totalSize);
			}
		});
	});
}

+ (void)cleanCacheWithCompleteBlock:(void (^)())completeBlock {
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		[[SDImageCache sharedImageCache] cleanDisk];

		[self deleteFilesInDir:[PathHelper logDir]];
		[self deleteFilesInDir:[PathHelper playCacheDir]];

		dispatch_async(dispatch_get_main_queue(), ^{
			if (completeBlock) {
				completeBlock();
			}
		});
	});
}

+ (void)checkSongCacheSizeWithCompleteBlock:(void (^)(unsigned long long cacheSize))completeBlock{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        unsigned long long totalSize = 0;
        
        NSUInteger imageCacheSize = [self calcDiskSizeOfDir:[[MIASongManage shareSongManage] songFilePath]];
        totalSize += imageCacheSize;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock(totalSize);
            }
        });
    });
}

+ (void)cleanSongCacheWithCompleteBlock:(void (^)())completeBlock{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self deleteFilesInDir:[[MIASongManage shareSongManage] songFilePath]];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    });
}

#pragma mark - Private Methods
+ (unsigned long long)calcDiskSizeOfDir:(NSString *)dirPath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *cacheFileList;
	NSEnumerator *cacheEnumerator;
	NSString *itemFilePath;

	unsigned long long cacheFolderSize = 0;

	cacheFileList = [fileManager subpathsOfDirectoryAtPath:dirPath error:nil];
	cacheEnumerator = [cacheFileList objectEnumerator];
	while (itemFilePath = [cacheEnumerator nextObject]) {
		NSDictionary *cacheFileAttributes = [fileManager attributesOfItemAtPath:[dirPath stringByAppendingPathComponent:itemFilePath] error:nil];
		cacheFolderSize += [cacheFileAttributes fileSize];
	}

	return cacheFolderSize;
}

+ (void)deleteFilesInDir:(NSString *)dirPath {
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *contents = [fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
	NSEnumerator *enumer = [contents objectEnumerator];
	NSString *filename;
	while ((filename = [enumer nextObject])) {
		[fileManager removeItemAtPath:[dirPath stringByAppendingPathComponent:filename] error:NULL];
	}
}

@end
