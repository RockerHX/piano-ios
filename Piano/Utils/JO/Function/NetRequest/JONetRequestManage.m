//
//  JONetRequestManage.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/11/16.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JONetRequestManage.h"
#import "JOFException.h"
#import "JOFFileManage.h"
#import "AFNetworking.h"

static NSString *const kFileDownloadTempDirectoriesName = @"JODownloadTemp/";
//从缓存的文件信息里面读取缓存的URL的key
static NSString *const kFileDownloadURLKey = @"NSURLSessionDownloadURL";
//从缓存的文件信息里面读取缓存文件名字的key
static NSString *const kFileDownloadTempNameKey = @"NSURLSessionResumeInfoTempFileName";

@interface JONetRequestManage()

@end

@implementation JONetRequestManage

+ (NSMutableDictionary *)shareRequestTaskDic{

    static NSMutableDictionary *requestTaskDic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        requestTaskDic = [NSMutableDictionary dictionary];
    });
    return requestTaskDic;
}

+ (void)networkReachabilityMonitoringHandler:(void(^)(JONetworkReachabilityStatus states))handler{

    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSInteger statesInteger = status;
        if (handler) {
            handler(statesInteger);
        }
    }];
}

+ (BOOL)networkReachabilityIsWifi{

    return [[AFNetworkReachabilityManager sharedManager] isReachableViaWiFi];
}

+ (void)cancelNetWorkReachabilityMonitoring{

   [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    
}

+ (void)cancelNetRequestWithIdentifier:(NSString *)identifier{

    if ([[[JONetRequestManage shareRequestTaskDic] allKeys] containsObject:identifier]) {
        
        id task = [[JONetRequestManage shareRequestTaskDic] objectForKey:identifier];
        
        if ([task isKindOfClass:[NSURLSessionDownloadTask class]]) {
           
            //不理会断点续传
//            [(NSURLSessionDownloadTask *)task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
//                
//                if (resumeData) {
//    
//                    NSFileManager *fileManager = [NSFileManager defaultManager];
//                    NSString *tempFilePath = [[[JOFFileManage documentPath] stringByAppendingString:kFileDownloadTempDirectoriesName] stringByAppendingString:identifier];
//                    //创建临时文件并写入数据,写入的只是一些文件的信息而已,真正的临时存的文件默认都在temp里面.
//                    [fileManager createFileAtPath:tempFilePath contents:resumeData attributes:nil];
//                    
//                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:tempFilePath];
//                    JOLog(@"dic:%@",dic);
//                }
//            }];
            
            [(NSURLSessionTask *)[[JONetRequestManage shareRequestTaskDic] objectForKey:identifier] cancel];
            
        }else{
            
            [(NSURLSessionTask *)[[JONetRequestManage shareRequestTaskDic] objectForKey:identifier] cancel];
        }
    }
}

+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
              fileProgressHandler:(NetFileOperationProgressHandler)progressHandler
                   successHandler:(NetRequestSuccessHandler)successHandler
                    failedHandler:(NetRequestFailedHandler)failedHandler{

    JOArgumentsCAssertNotNil(config, @"JONetRequestManage: config is nil.");
    
#define Cache_Request \
    if (identifier && [identifier length]) { \
        if (![[[JONetRequestManage shareRequestTaskDic] allKeys] containsObject:identifier]) { \
            [[JONetRequestManage shareRequestTaskDic] setObject:dataTask forKey:identifier]; \
        }else{ \
            [JOFException exceptionWithName:@"JONetRequestManage exception!" reason:@"identifier已经存在,请勿添加两个相同的identifier"]; \
        } \
    } \

    
#define Remove_Cache_Request \
    if (identifier&&[identifier length]) { \
        [[JONetRequestManage shareRequestTaskDic] removeObjectForKey:identifier]; \
    } \


#define Session_Configuration(sessionConfiguration) \
    NSURLSessionConfiguration *configuration = ({ \
        configuration = sessionConfiguration; \
        if (configuration) { \
            configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; \
            [configuration setTimeoutIntervalForRequest:30.]; \
            [configuration setTimeoutIntervalForResource:30.]; \
        } \
        configuration; \
    }); \


#define Request_Success_Handler \
    if (successHandler) { \
        successHandler(responseObject); \
    } \


    
#define Request_Failed_Handler \
    if (failedHandler) { \
        failedHandler([error.userInfo objectForKey:NSLocalizedDescriptionKey]); \
    } \

#define File_Progress_Handler(progress) \
    if (progress) { \
        dispatch_async(dispatch_get_main_queue(), ^{ \
            if (progressHandler) { \
                progressHandler(progress.fractionCompleted); \
            } \
        }); \
    } \

    if ([config isKindOfClass:[JODataRequestConfig class]]) {
        
        JODataRequestConfig *httpsRequestDataConfig = (JODataRequestConfig *)config;
        //若未设置URLSessionConfiguration则给定默认的一个配置
        Session_Configuration(httpsRequestDataConfig.urlSessionConfiguration);
        
        AFHTTPSessionManager *manager = ({
            manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
            manager;
        });
        
        NSURLSessionDataTask *dataTask = nil;
        if (httpsRequestDataConfig.httpRequestType == HttpRequestTypePost) {
            //Post的方式
            dataTask = [manager POST:httpsRequestDataConfig.httpURLString
                          parameters:httpsRequestDataConfig.httpPostData
                            progress:nil
                             success:^(NSURLSessionDataTask *task, id responseObject) {
                                 
                                 Request_Success_Handler;
                                 Remove_Cache_Request;
                             }
                             failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                JOLog(@"errordomain:%@",error.domain);
                                JOLog(@"errorDic:%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
                                
                                if(!([[error.userInfo objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"cancelled"]||[[error.userInfo objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"已取消"])){
                            
                                    JOLog(@"error:%@",error);
                                    Request_Failed_Handler;
                                    }
                                 Remove_Cache_Request;
                /*
                 if (task.state == NSURLSessionTaskStateCanceling) {
                 
                 NSLog(@"cancel");
                 }else if(task.state == NSURLSessionTaskStateRunning){
                 
                 NSLog(@"Running");
                 }else if(task.state == NSURLSessionTaskStateSuspended){
                 
                 NSLog(@"suspended");
                 }else if(task.state == NSURLSessionTaskStateCompleted){
                 
                 
                 NSLog(@"completed");
                 }
                 */
                             }
                        ];
            
        }else if(httpsRequestDataConfig.httpRequestType == HttpRequestTypeGet){
            //Get方式
            dataTask = [manager GET:httpsRequestDataConfig.httpURLString
                         parameters:httpsRequestDataConfig.httpPostData
                           progress:nil
                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                
                                Request_Success_Handler;
                                Remove_Cache_Request;
                
                        }
                            failure:^(NSURLSessionDataTask *task, NSError *error) {
                                
                                JOLog(@"errordomain:%@",error.domain);
                                JOLog(@"errorDic:%@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
                                
                                if(!([[error.userInfo objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"cancelled"]||[[error.userInfo objectForKey:NSLocalizedDescriptionKey] isEqualToString:@"已取消"])){
                                    
                                    JOLog(@"error:%@",error);
                                    Request_Failed_Handler;
                                    }
                                Remove_Cache_Request;
                            }
                        ];
        }
        Cache_Request;
        [dataTask resume];
        
    }else if ([config isKindOfClass:[JOFileUploadConfig class]]){
        //文件上传
        
        JOFileUploadConfig *fileUploadConfig = (JOFileUploadConfig *)config;
        Session_Configuration(fileUploadConfig.urlSessionConfiguration);
        
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        AFJSONResponseSerializer *JSONResponseSerializer = [AFJSONResponseSerializer serializer];
        JSONResponseSerializer.acceptableContentTypes = [JSONResponseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        manager.responseSerializer = JSONResponseSerializer;
        
        
//        [[AFJSONResponseSerializer serializer] setAcceptableContentTypes:<#(NSSet<NSString *> * _Nullable)#>]
//        manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
        NSURLSessionUploadTask *dataTask = nil;
        
        if (fileUploadConfig.isStreameRequest) {
            
            NSMutableURLRequest *request =({
                
                Block_Variable NSString *methodStr = @"";
                Block_Variable NSString *URLStringStr = @"";
                Block_Variable NSDictionary *postDataDic = nil;
                Block_Variable NSData *fileOfData = nil;
                Block_Variable NSString *nameStr = @"";
                Block_Variable NSString *fileNameStr = @"";
                Block_Variable NSString *mimeTypeStr = @"";
                fileUploadConfig.fileStreamURLRequestHandler(^(NSString *method, NSString *URLString, NSDictionary *postData){
                    methodStr = method;
                    URLStringStr = URLString;
                    postDataDic = postData;
                },^(NSData *fileData, NSString *name, NSString *fileName, NSString *mimeType){
                    fileOfData = fileData;
                    nameStr = name;
                    fileNameStr = fileName;
                    mimeTypeStr = mimeType;
                });
                
                request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:methodStr
                                                                                     URLString:URLStringStr
                                                                                    parameters:postDataDic
                                                                     constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                                         
                                                                         [formData appendPartWithFileData:fileOfData
                                                                                                     name:nameStr
                                                                                                 fileName:fileNameStr
                                                                                                 mimeType:mimeTypeStr];
                                                                         
                                                                     }
                                                                                         error:nil];
                request;
                
            });
            
            //是文件流的形式
            dataTask = [manager uploadTaskWithStreamedRequest:request
                                                     progress:^(NSProgress * _Nonnull uploadProgress) {
                                                         File_Progress_Handler(uploadProgress);
                                                     }
                                            completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                                    if (error) {
                                                        //失败
                                                        JOLog(@"uploadError:%@",error);
                                                        Request_Failed_Handler;
                                                        Remove_Cache_Request;
                                                    }else{
                                                        //成功
                                                        Request_Success_Handler;
                                                        Remove_Cache_Request;
                                                    }
                                                    
                                            }
                        ];
            
        }else{
            //不是流的形式
            if (fileUploadConfig.filePath) {
                //文件的路径
                dataTask = [manager uploadTaskWithRequest:fileUploadConfig.request
                                                 fromFile:[NSURL URLWithString:fileUploadConfig.filePath]
                                                 progress:^(NSProgress * _Nonnull uploadProgress) {
                                                     File_Progress_Handler(uploadProgress);
                                                 }
                                        completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

                                                    if (error) {
                                                        //失败
                                                        JOLog(@"uploadError:%@",error);
                                                        Request_Failed_Handler;
                                                        Remove_Cache_Request;
                                                    }else{
                                                        //成功
                                                        Request_Success_Handler;
                                                        Remove_Cache_Request;
                                                    }
                    
                                        }
                            ];
            }else if (fileUploadConfig.fileData){
                //文件的Data
                dataTask = [manager uploadTaskWithRequest:fileUploadConfig.request
                                                 fromData:fileUploadConfig.fileData
                                                 progress:^(NSProgress * _Nonnull uploadProgress) {
                                                     File_Progress_Handler(uploadProgress);
                                                 }
                                        completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                    
                                                    if (error) {
                                                        //失败
                                                        JOLog(@"uploadError:%@",error);
                                                        Request_Failed_Handler;
                                                        Remove_Cache_Request;
                                                    }else{
                                                        //成功
                                                        Request_Success_Handler;
                                                        Remove_Cache_Request;
                                                    }
                                        }
                            ];
            }else{
            
                dataTask = [NSURLSessionUploadTask new];
            }
        }
        
        Cache_Request;
        [dataTask resume];
        
    }else if ([config isKindOfClass:[JOFileDownloadConfig class]]){
    
        //创建临时的文件夹
        
        NSFileManager *fileManager = ({
        
            fileManager = [NSFileManager defaultManager];
            NSError *error;
            [fileManager createDirectoryAtPath:[[JOFFileManage documentPath] stringByAppendingString:kFileDownloadTempDirectoriesName] withIntermediateDirectories:NO attributes:nil error:&error];
            fileManager;
        });
        
        NSString *tempFilePath = [[[JOFFileManage documentPath] stringByAppendingString:kFileDownloadTempDirectoriesName] stringByAppendingString:identifier];
        NSMutableDictionary *resumeDownloadInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:tempFilePath];
        
        JOFileDownloadConfig *fileDownloadConfig = (JOFileDownloadConfig *)config;
        if ([fileDownloadConfig isCleanExistFile] && resumeDownloadInfoDic) {
            //清空原来的文件
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error;
            [fileManager removeItemAtPath:[fileDownloadConfig.fileSavePath stringByAppendingString:fileDownloadConfig.fileSaveName] error:&error];
            
//            NSMutableDictionary *resumeDownloadInfoDic = [NSMutableDictionary dictionaryWithContentsOfFile:tempFilePath];
            [fileManager removeItemAtPath:[[JOFFileManage tempPath] stringByAppendingString:[resumeDownloadInfoDic objectForKey:kFileDownloadTempNameKey]] error:&error];
            [fileManager removeItemAtPath:tempFilePath error:&error];
            
        }
        
        Session_Configuration(fileDownloadConfig.urlSessionConfiguration);
        
        AFURLSessionManager *manager = ({
            
            manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            manager;
        });
        
        NSURLSessionDownloadTask *dataTask = ({

            if ([JOFFileManage  fileExistAtFilePath:tempFilePath]) {
                //存在临时文件  如果下载的临时存储的文件存在则自动开始接着上次下载的地方继续下载
                
                if (fileDownloadConfig.resumeURLString && [fileDownloadConfig.resumeURLString length]) {
                    //首先确定这个需要恢复的URL是否被重新设置过
                    
                    if (![[resumeDownloadInfoDic objectForKey:kFileDownloadURLKey] isEqualToString:fileDownloadConfig.resumeURLString]) {
                        //如果给定的不一致,则需要用新给的URL替换掉原来的地址.
                        [resumeDownloadInfoDic setObject:fileDownloadConfig.resumeURLString forKey:kFileDownloadURLKey];
                    }
                    
                }
                
                NSData *resumeData = [NSData dataWithContentsOfFile:tempFilePath];
                dataTask = [manager downloadTaskWithResumeData:resumeData
                                                      progress:^(NSProgress * _Nonnull downloadProgress) {
                                                          File_Progress_Handler(downloadProgress);
                                                          
                                                      }
                                                   destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                       
                                                       NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:fileDownloadConfig.fileSavePath];
                                                       return [documentsDirectoryPath URLByAppendingPathComponent:fileDownloadConfig.fileSaveName];
                                                       
                                                   }
                                             completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                                 
                                                 if (error == nil) {
                                                     
                                                     if (successHandler) {
                                                         successHandler([NSDictionary dictionary]);
                                                     }
                                                     Remove_Cache_Request;
                                                 }else{
                                                     
                                                     JOLog(@"downloadError:%@",error);
                                                     Request_Failed_Handler;
                                                     Remove_Cache_Request;
                                                     
                                                 }
                                             }
                            ];
                
                
            }else{
                //不存在临时文件的时候
                dataTask = [manager downloadTaskWithRequest:fileDownloadConfig.request
                                                   progress:^(NSProgress * _Nonnull downloadProgress) {
                                                       
                                                       File_Progress_Handler(downloadProgress);
                                                   }
                                                destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                                                    
                                                    NSURL *documentsDirectoryPath = [NSURL fileURLWithPath:fileDownloadConfig.fileSavePath];
                                                    return [documentsDirectoryPath URLByAppendingPathComponent:fileDownloadConfig.fileSaveName];
                                                    
                                                }
                                          completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                                              
                                              if (error == nil) {
                                                  
                                                  if (successHandler) {
                                                      successHandler([NSDictionary dictionary]);
                                                  }
                                                  Remove_Cache_Request;
                                                  
                                              }else{
                                                  
                                                  JOLog(@"downloadtttttError:%@",error);
                                                  Request_Failed_Handler;
                                                  Remove_Cache_Request;
                                                  
                                              }
                                          }
                            ];
            }
            
            dataTask;
        });
    
        Cache_Request
        [dataTask resume];
    }
   
   
#undef Cache_Request
#undef Remove_Cache_Request
#undef Session_Configuration
#undef Request_Success_Handler
#undef Request_Failed_Handler
#undef File_Progress_Handler

}

+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
                   successHandler:(NetRequestSuccessHandler)successHandler
                    failedHandler:(NetRequestFailedHandler)failedHandler{

    [JONetRequestManage startNetRequestWithConfig:config
                                requestIdentifier:identifier
                              fileProgressHandler:nil
                                   successHandler:successHandler
                                    failedHandler:failedHandler];
}

+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
                    failedHandler:(NetRequestFailedHandler)failedHandler{

    [JONetRequestManage startNetRequestWithConfig:config
                                requestIdentifier:identifier
                              fileProgressHandler:nil
                                   successHandler:nil
                                    failedHandler:failedHandler];
}


+ (void)startNetRequestWithConfig:(JOConfig *)config
                requestIdentifier:(NSString *)identifier
              fileProgressHandler:(NetFileOperationProgressHandler)progressHandler
                    failedHandler:(NetRequestFailedHandler)failedHandler{

    [JONetRequestManage startNetRequestWithConfig:config
                                requestIdentifier:identifier
                              fileProgressHandler:progressHandler
                                   successHandler:nil
                                    failedHandler:failedHandler];
}



@end
