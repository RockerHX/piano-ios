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
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)url completionHandler:(void (^)(HXDownLoadCache *cache, NSData *data, NSURLResponse *response, NSError *error))completionHandler;

/**
 *  Custom Request
 */
- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request completionHandler:(void (^)(HXDownLoadCache *cache, NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)url configuration:(NSURLSessionConfiguration *)configuration completionHandler:(void (^)(HXDownLoadCache *cache, NSData *data, NSURLResponse *response, NSError *error))completionHandler;
- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request configuration:(NSURLSessionConfiguration *)configuration completionHandler:(void (^)(HXDownLoadCache *cache, NSData *data, NSURLResponse *response, NSError *error))completionHandler;

@end


NS_ASSUME_NONNULL_END
