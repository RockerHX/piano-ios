//
//  HXDownLoadCache.m
//  CacheVideoDemo
//
//  Created by miaios on 16/5/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDownLoadCache.h"


@implementation HXDownLoadCache

#pragma mark - Singleton Methods
+ (instancetype)cache {
    static HXDownLoadCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [HXDownLoadCache new];
    });
    return cache;
}

+ (instancetype)cacheWithCache:(NSURLCache *)cache {
    [NSURLCache setSharedURLCache:cache];
    return [self cache];
}

#pragma mark - Property
- (NSURLCache *)cache {
    return [NSURLCache sharedURLCache];
}

#pragma mark - Public Methods
- (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)url completionHandler:(nonnull void (^)(HXDownLoadCache *, NSData *, NSURLResponse *, NSError *))completionHandler {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:10.0f];
    return [self downLoadWithRequest:request completionHandler:completionHandler];
}

- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request completionHandler:(nonnull void (^)(HXDownLoadCache *, NSData *, NSURLResponse *, NSError *))completionHandler {
    
    NSURLSession *session = [NSURLSession sharedSession];
    return [self downLoadWithRequest:request session:session completionHandler:completionHandler];
}

- (NSURLSessionDownloadTask *)downLoadWithURL:(NSURL *)url configuration:(NSURLSessionConfiguration *)configuration completionHandler:(nonnull void (^)(HXDownLoadCache *, NSData *, NSURLResponse *, NSError *))completionHandler {
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return [self downLoadWithRequest:request configuration:configuration completionHandler:completionHandler];
}

- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request configuration:(NSURLSessionConfiguration *)configuration completionHandler:(nonnull void (^)(HXDownLoadCache *, NSData *, NSURLResponse *, NSError *))completionHandler {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    return [self downLoadWithRequest:request session:session completionHandler:completionHandler];
}

#pragma mark - Private Methods
- (NSURLSessionDownloadTask *)downLoadWithRequest:(NSURLRequest *)request session:(NSURLSession *)session completionHandler:(void (^)(HXDownLoadCache *, NSData *, NSURLResponse *, NSError *))completionHandler {
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *data = [NSData dataWithContentsOfURL:location];
        NSCachedURLResponse *cachedResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
        if ((!cachedResponse) && response && data) {
            NSCachedURLResponse *cachedURLResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            [[NSURLCache sharedURLCache] storeCachedResponse:cachedURLResponse forRequest:request];
        }
        
        if (completionHandler) {
            completionHandler(self, data, response, error);
        }
    }];
    [task resume];
    return task;
}

@end
