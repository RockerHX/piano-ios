//
//  JOURLFileDownloadConfig.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOConfig.h"

@interface JOFileDownloadConfig : JOConfig

/*文件下载过程中如果cancel掉该下载任务,会默认把已经下载的数据存在一个temp的文件中,
 你继续下载的时候会根据给定的identifier去继续下载该任务,如果你想测试该功能请下载一个相对比较大一点的文件,
 因为过小的文件下载,是默认不会将文件保存到temp中的.*/

/*
    post为传的参数
    若需要已http的形式下载的话可以参照JOURLFileUploadConfig中的设置.

    NSData *httpBody = nil;
    if ([NSJSONSerialization isValidJSONObject:postData]) {
    NSError *error;
    NSData *registerData = [NSJSONSerialization dataWithJSONObject:postData options:kNilOptions error:&error];
    NSString *postString = [[NSString alloc] initWithData:registerData encoding:NSUTF8StringEncoding];
    httpBody = [postString dataUsingEncoding:NSUTF8StringEncoding];
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];//若无参数,直接设置这个就OK

    [request setHTTPBody:httpBody];

*/

//下载的文件保存到本地的路径.
@property (nonatomic, copy) NSString *fileSavePath;
//下载的文件保存到本地的名字
@property (nonatomic, copy) NSString *fileSaveName;
//下载的Request. 是否需要根据传参来下载东西,可以在Request里面设置传参,
@property (nonatomic, copy) NSURLRequest *request;
/**
 *  @see JOHttpsRequestDataConfig的文件中的解释
 */
@property (nonatomic, strong) NSURLSessionConfiguration *urlSessionConfiguration;

//是否在下载前清空已存在的该文件(原来保存的未下载完成的临时文件也会一起删除). 根据给定的路径与名字来判断文件是否存在.
//YES:则会在下载前删除掉已存在的文件  NO:则不会删除. (所以NO的话则带表下次下载可以根据上次未完成的地方继续下载)
@property (nonatomic, assign) BOOL isCleanExistFile;

/*
 * 用在需要恢复上次未完成的下载任务的时候.
 * 针对的情况:下载任务,如果资源的URL是有时效的,每一次请求资源的URL都会发生改变.若无变化则不用理会.
 * 可以设置该URL的值,这样每次恢复的时候会将该URL与原来保存的URL信息做比较,若不同则会按此URL去替换.
 */
@property (nonatomic, copy) NSString *resumeURLString;

/**
 *  设置文件下载的相关信息.
 *
 *  @param fileSavePath 文件保存的地址.
 *  @param fileSaveName 文件保存的名字.
 *  @param isClean      下载前是否清空已存在的文件.
 */
- (void)setFileSavePath:(NSString *)fileSavePath fileSaveName:(NSString *)fileSaveName isCleanExistFile:(BOOL)isClean;

@end
