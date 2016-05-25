//
//  JOURLFileUploadConfig.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFileUploadConfig.h"
#import "JOFException.h"

@implementation JOFileUploadConfig

- (void)synthFileStreamURLRequestHandler:(FileStreamURLRequestHandler)handler{

    self.fileStreamURLRequestHandler = nil;
    self.fileStreamURLRequestHandler = handler;
}

- (void)setUploadFile:(id)file request:(NSURLRequest *)reqeust{
    
    JOArgumentsCAssertNotNil(file&&reqeust, @"JOFileUploadConfig: setUploadFile:request: file,request one of them is error.");
    self.request = nil;
    self.request = reqeust;
    
    self.isStreameRequest = NO;
    
    [self setFile:file];
}

- (void)setFile:(id)file{
    
    if ([file isKindOfClass:[NSString class]]) {
        //文件的路径
        self.filePath = nil;
        self.filePath = file;
    }else if ([file isKindOfClass:[NSData class]]){
        //文件的Data
        self.fileData = nil;
        self.fileData = file;
    }else{
        
        [JOFException exceptionWithName:@"JOFileUploadConfig Exception!" reason:@"file的类型不支持,现在只支持NNSString NSData类型"];
    }
}

@end
