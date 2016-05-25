//
//  JONetRequestManage.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/16.
//  Copyright © 2015年 刘维. All rights reserved.
//

//#import "JSONModel.h"
#import "JOHttpRequestType.h"
#import "JODataRequestConfig.h"
#import "JOFileUploadConfig.h"
#import "JOFileDownloadConfig.h"

typedef NS_ENUM(NSInteger,JONetworkReachabilityStatus) {

    JONetworkReachabilityStatusUnknown          = -1, //未知的网络状态.
    JONetworkReachabilityStatusNotReachable     = 0,//无任何网络
    JONetworkReachabilityStatusReachableViaWWAN = 1,//2G 3G 4G...手机运行商
    JONetworkReachabilityStatusReachableViaWiFi = 2,//Wifi
};

/**
 *  文件存在上传与下载的进度Block.
 *
 *  @param progressValue 进的的值.
 */
typedef void(^NetFileOperationProgressHandler)(CGFloat progressValue);

/**
 *  用于返回的数据的解析,传入你想要将解析后的数据模型(JSONModel)传给的对象.
 *  (其实只是使用这个对象,然后得到这个对象的类名去初始化并赋值一个对象,并返回该对象)
 *  JSONModel *(^JSONModelParseHandler) (JSONModel *josnModel)
 *
 *  @param josnModel 传入你想要赋值的JSONModel数据模型对象.
 *
 *  @return 返回解析后的数据模型.
 */
//typedef id(^JSONModelParseHandler) (JSONModel *josnModel);

/**
 *  网络请求成功返回了数据,JSONModelParseHandler可以将返回的数据解析为想要的JSONModel的数据模型.
 *  可以使用:- manageMissionCompleteHandler 方法来获取返回的数据.
 *
 *  @param parseHandler JSONModelParseHandler.
 */
//typedef void(^NetManageMissionSuccessHandler) (JSONModelParseHandler parseHandler);

/**
 *  网络请求成功返回了数据,JSONModelParseHandler可以将返回的数据解析为想要的JSONModel的数据模型.
 *
 *  @param parseHandler JSONModelParseHandler
 */
//typedef void(^NetReqeustDataParseHandler) (JSONModelParseHandler parseHandler);

/**
 *  网络请求成功返回数据的Handler.得到的数据类型为已经转换为字典的类型.
 *
 *  @param response 网络请求返回的数据.
 */
typedef void(^NetRequestSuccessHandler) (NSDictionary *response);

/**
 *  网络请求失败的Handler.
 *
 *  @param failedDescription 失败的描述.
 */
typedef void(^NetRequestFailedHandler) (NSString *failedDescription);


@interface JONetRequestManage : NSObject

/**
 *  该方法用来监听整个网络的状态.网络发生改变将通过该Hanlder得到响应.
 *
 *  @param handler 网络状态更改的Handler.
 */
+ (void)networkReachabilityMonitoringHandler:(void(^)(JONetworkReachabilityStatus states))handler;

/**
 *  取消监听网络的状态.
 */
+ (void)cancelNetWorkReachabilityMonitoring;

/**
 *  获取当前网络的状态
 *
 *  @return JONetworkReachabilityStatus
 */
+ (BOOL)networkReachabilityIsWifi;

/**
 *  根据给定的标示去取消一个网络请求.
 *
 *  @param identifier 标示.
 */
+ (void)cancelNetRequestWithIdentifier:(NSString *)identifier;

/**
 *  执行一个网络请求.
 *
 *  @param config           网络配置的类.不同的配置类代表不同的网络请求.
 *  @param identifier       自定义的网络的唯一标示.一般的网络请求可以不设置它(传nil 或者@"")(涉及到需要取消这个任务的时候就必须要设置这个标示),
 *                          多半是用于文件的下载与上传进行中的时候取消这个网络任务.
 *  @param progressHandler  NetFileOperationProgressHandler 文件上传或下载的进度.
 *  @param jsonModelHanler  NetManageMissionSuccessHandler 可以将网络返回得到的数据转作为你传入的数据模型对象返回.
 *                          ps:必须确保返回的数据与你给的数据模型是一一对应的,不然转换会失败.
 *  @param successHandler   MissionCompleteHandler 任务完成的回调,返回的对象为从服务器得到的数据,已转换为字典类型.
 *  @param interruptHandler MissionInterruptHandler 任务中断的回调,返回的为任务中断的原因.
 */
+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
              fileProgressHandler:(NetFileOperationProgressHandler)progressHandler
                   successHandler:(NetRequestSuccessHandler)successHandler
                    failedHandler:(NetRequestFailedHandler)failedHandler;


/*你需要的应该下面方法中的一种,请自行根据自己需要的网络处理的handler进行选择*/

+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
                   successHandler:(NetRequestSuccessHandler)successHandler
                    failedHandler:(NetRequestFailedHandler)failedHandler;

+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
                    failedHandler:(NetRequestFailedHandler)failedHandler;


+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
              fileProgressHandler:(NetFileOperationProgressHandler)progressHandler
                    failedHandler:(NetRequestFailedHandler)failedHandler;



@end
