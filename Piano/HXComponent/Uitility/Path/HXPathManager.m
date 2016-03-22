//
//  HXPathManager.m
//  Piano
//
//  Created by miaios on 16/3/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPathManager.h"


@implementation HXPathManager


#pragma mark - Singleton Methods
+ (instancetype)manager {
    static HXPathManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXPathManager alloc] init];
    });
    return manager;
}

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _homeDirectory     = NSHomeDirectory();
    _documentDirectory = [self searchPath:NSDocumentDirectory];
    _libraryDirectory  = [self searchPath:NSLibraryDirectory];
    _cacheDirectory    = [self searchPath:NSCachesDirectory];
    _tempDirectory     = NSTemporaryDirectory();
}

#pragma mark - Public Methods
- (NSString *)directoryPath:(HXPathDirectory)directory {
    switch (directory) {
        case HXPathDirectoryHome: {
            return _homeDirectory;
            break;
        }
        case HXPathDirectoryDocument: {
            return _documentDirectory;
            break;
        }
        case HXPathDirectoryLibrary: {
            return _libraryDirectory;
            break;
        }
        case HXPathDirectoryCache: {
            return _cacheDirectory;
            break;
        }
        case HXPathDirectoryTemp: {
            return _tempDirectory;
            break;
        }
    }
}

- (NSString *)storePathWithRelativePath:(NSString *)relativePath fileName:(NSString *)fileName {
    NSString *path = [_cacheDirectory stringByAppendingString:relativePath];
    [self checkShouldCreateDirectoryWithPath:path];
    
    return [path stringByAppendingString:fileName];
}

#pragma mark - Private Methods
- (NSString *)searchPath:(NSSearchPathDirectory)directory {
    return [NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES) lastObject];
}

- (BOOL)checkShouldCreateDirectoryWithPath:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]) {
        return [fileManager createDirectoryAtPath:path withIntermediateDirectories:nil attributes:nil error:nil];
    }
    return NO;
}

@end
