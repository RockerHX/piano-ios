//
//  HXDownLoadCache.h
//  CacheVideoDemo
//
//  Created by miaios on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


@interface HXDownLoadCache : NSObject

@property (nonatomic, weak, readonly) NSURLCache *cache;

+ (instancetype)cache;
+ (instancetype)cacheWithCache:(NSURLCache *)cache;

/**
 *  Timeout     : 10.0f
 *  CachePolicy : NSURLRequestReturnCacheDataElseLoad
 */
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)url completionHandler:(void (^)(NSData * __nullable data, NSURL * __nullable location, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

/**
 *  Custom Request
 */
- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * __nullable data, NSURL * __nullable location, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)url configuration:(NSURLSessionConfiguration *)configuration completionHandler:(void (^)(NSData * __nullable data, NSURL * __nullable location, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;
- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request configuration:(NSURLSessionConfiguration *)configuration completionHandler:(void (^)(NSData * __nullable data, NSURL * __nullable location, NSURLResponse * __nullable response, NSError * __nullable error))completionHandler;

@end


NS_ASSUME_NONNULL_END
