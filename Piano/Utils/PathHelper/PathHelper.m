//
//  PathHelper.m
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "PathHelper.h"
#import "NSString+IsNull.h"
#import "NSString+MD5.h"

#define DOCUMENT_PATH       [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define LIBRARY_PATH        [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
#define CACHE_PATH          [LIBRARY_PATH stringByAppendingString:@"/Caches"]

@interface PathHelper()
@end

@implementation PathHelper {
}

+ (NSString *)cacheDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [CACHE_PATH stringByAppendingPathComponent:@"/Cache"];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+ (NSString *)playCacheDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [CACHE_PATH stringByAppendingPathComponent:@"/Cache/Play"];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+ (NSString *)favoriteCacheDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [CACHE_PATH stringByAppendingPathComponent:@"/Cache/Favorite"];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+ (NSString *)userDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [CACHE_PATH stringByAppendingPathComponent:@"/User"];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+ (NSString *)userDirWithUID:(NSString *)uid {
    NSString *uidPath = [NSString isNull:uid] ? @"0" : uid;
    NSString *subDir = [NSString stringWithFormat:@"/User/%@", uidPath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [CACHE_PATH stringByAppendingPathComponent:subDir];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+ (NSString *)logDir {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [CACHE_PATH stringByAppendingPathComponent:@"/Log"];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

+ (NSString *)shareArchivePathWithUID:(NSString *)uid {
    return [NSString stringWithFormat:@"%@/sharelist.archive", [self userDirWithUID:uid]];
}

+ (NSString *)favoriteArchivePathWithUID:(NSString *)uid {
    return [NSString stringWithFormat:@"%@/favorite.archive", [self userDirWithUID:uid]];
}

+ (NSString *)playlistArchivePathWithUID:(NSString *)uid {
	return [NSString stringWithFormat:@"%@/playlist.archive", [self userDirWithUID:uid]];
}

+ (NSString *)genMusicFilenameWithUrl:(NSString *)url {
    return [NSString stringWithFormat:@"%@/%@", [self favoriteCacheDir], [NSString md5HexDigest:url]];
}

+ (NSString *)logFileName {
    return [NSString stringWithFormat:@"%@/app.log", [self logDir]];
}

@end
















