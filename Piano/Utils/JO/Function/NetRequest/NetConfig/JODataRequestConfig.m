//
//  JOHttpRequestDataConfig.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JODataRequestConfig.h"
#import "JOFException.h"

@implementation JODataRequestConfig

- (void)setHttpURLString:(NSString *)httpURLString
                postData:(NSDictionary *)postData
             requestType:(HttpRequestType)requestType{
    
    JOArgumentsCAssertNotNil(httpURLString&&[httpURLString length], @"HttpURLString is error.");
    
    self.httpURLString = nil;
    self.httpURLString = httpURLString;
    
    self.httpPostData = nil;
    self.httpPostData = postData;
    
    self.httpRequestType = requestType;
}

- (void)setHttpURLString:(NSString *)httpURLString
             requestType:(HttpRequestType)requestType{
    
    [self setHttpURLString:httpURLString postData:[NSDictionary dictionary] requestType:requestType];
}

@end
