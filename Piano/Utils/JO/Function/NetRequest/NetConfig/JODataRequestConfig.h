//
//  JOHttpRequestDataConfig.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOConfig.h"
#import "JOHttpRequestType.h"

@interface JODataRequestConfig : JOConfig

//网络请求的http的地址.
@property (nonatomic, copy) NSString *httpURLString;
//请求需要带的参数.
@property (nonatomic, copy) NSDictionary *httpPostData;
//请求的类型,是get 还是 post.
@property (nonatomic, assign) HttpRequestType httpRequestType;
/*
 * NSURLSessionConfiguration可以提供从网络访问性能，到cookie，安全性，缓存策略，自定义协议，启动事件设置，以及用于移动设备优化的几个新属性
 * 常用的可能是网络的请求超时的设置,可以通过timeoutIntervalForRequest和timeoutIntervalForResource来设置.
 * 若不设置则使用默认的设置请求超时时间为30s.
 * ps:timeoutIntervalForRequest:请求数据包的限制时间,如果超过该时间就当网络连接超时处理
 * timeoutIntervalForResource:请求资源整体限制时间,适用于后台传输，而不是用户实际上可能想要等待的任何东西
 */
@property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfiguration;

/**
 *  设置网络请求的参数.
 *
 *  @param httpURLString 请求的http地址.
 *  @param postData      请求的参数.
 *  @param requestType   请求的类型: post get
 *  @param requestTag    请求的标示:唯一的.
 */
- (void)setHttpURLString:(NSString *)httpURLString
                postData:(NSDictionary *)postData
             requestType:(HttpRequestType)requestType;

/**
 *  设置网络请求的参数.ps:针对不需要传参数的网络请求.
 *
 *  @param httpURLString 请求的http地址.
 *  @param requestType   请求的类型: post get
 *  @param requestTag    请求的标示:唯一的.
 */
- (void)setHttpURLString:(NSString *)httpURLString
             requestType:(HttpRequestType)requestType;

@end
