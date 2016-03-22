//
//  HXPathManager.h
//  Piano
//
//  Created by miaios on 16/3/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, HXPathDirectory) {
    HXPathDirectoryHome,
    HXPathDirectoryDocument,
    HXPathDirectoryLibrary,
    HXPathDirectoryCache,
    HXPathDirectoryTemp,
};


@interface HXPathManager : NSObject

@property (nonatomic, strong, readonly) NSString *homeDirectory;
@property (nonatomic, strong, readonly) NSString *documentDirectory;
@property (nonatomic, strong, readonly) NSString *libraryDirectory;
@property (nonatomic, strong, readonly) NSString *cacheDirectory;
@property (nonatomic, strong, readonly) NSString *tempDirectory;

+ (instancetype)manager;

- (NSString *)directoryPath:(HXPathDirectory)directory;
- (NSString *)storePathWithRelativePath:(NSString *)relativePath fileName:(NSString *)fileName;

@end
