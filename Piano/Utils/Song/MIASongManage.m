//
//  MIAFileDownloadManage.m
//  Piano
//
//  Created by 刘维 on 16/5/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASongManage.h"
#import "PathHelper.h"
#import "NSString+MD5.h"
#import "NSString+IsNull.h"
#import "JONetRequestManage.h"
#import "AFNetworkReachabilityManager.h"
#import "JOBaseSDK.h"

NSString *const kMIASongDownloadFinishedNoticeKey = @"kMIASongDownloadFinishedNoticeKey";
NSString *const kMIASongDownloadNoticeURLKey = @"kMIASongDownloadNoticeURLKey";
static NSString *const kSongCachePath = @"/Song";//缓存的路径名
//static NSInteger const kMaxSongDownloadCount = 1;//最大的歌曲同时下载数量

@interface MIASongManage(){

    dispatch_semaphore_t semaphore;
    dispatch_queue_t downloadQueue;
    BOOL downloadState;
    
}

@property (nonatomic, strong) NSMutableArray *downloadURLArray;
@property (nonatomic, copy) NSString *currentDownloadURLString;

@end

@implementation MIASongManage

+ (MIASongManage *)shareSongManage{
    
    static MIASongManage * songManage;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        songManage = [[self alloc] init];
    });
    return songManage;
}

- (instancetype)init{

    self = [super init];
    if (self) {
       
        self.downloadURLArray = nil;
        self.downloadURLArray = [NSMutableArray array];
        semaphore = dispatch_semaphore_create(0);
        downloadQueue = dispatch_queue_create("com.mia.SongDownload.quque", DISPATCH_QUEUE_CONCURRENT);
        [self songDownloadSemaphore];
        
        [self obbserverNetWorkState];
    }
    return self;
}

- (void)obbserverNetWorkState{
    
    [JONetRequestManage networkReachabilityMonitoringHandler:^(JONetworkReachabilityStatus states) {
       
        if (states != JONetworkReachabilityStatusReachableViaWiFi) {
            //取消掉正在执行的歌曲下载并 清空所有的下载队列 如果需要重新下载需要再次点击下载按钮
            if (downloadState) {
                [self showNetworkIsNotWifiAlert];
            }
            
            [JONetRequestManage cancelNetRequestWithIdentifier:_currentDownloadURLString];
            [_downloadURLArray removeAllObjects];
            downloadState = NO;
        }
    }];
}

//- (void)removeObbserverNetworkState{
//
//    [[AFNetworkReachabilityManager manager] stopMonitoring];
//}

- (void)startDownloadSongWithURLArray:(NSArray *)urlArray{

    [_downloadURLArray addObjectsFromArray:urlArray];
    
    if ([JONetRequestManage networkReachabilityIsWifi]) {
        
        if (!downloadState) {
            [self sendSemaphore];
        }
    }else{
        //不是在wifi环境下则给出提示
        [self showNetworkIsNotWifiAlert];
    }
}

- (void)startDownloadSongWithURLString:(NSString *)urlString{

    [_downloadURLArray addObject:urlString];
    
    if ([JONetRequestManage networkReachabilityIsWifi]) {
        
        if (!downloadState) {
            [self sendSemaphore];
        }
    }else{
        
        [self showNetworkIsNotWifiAlert];
    }
}

#pragma mark - alert Tip

- (void)showNetworkIsNotWifiAlert{

//    [self removeObbserverNetworkState];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Mia音乐" message:@"歌曲仅在wifi环境下才能下载,请检查你的网络状态." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

#pragma mark - semaphore

- (void)sendSemaphore{

    dispatch_async(downloadQueue, ^{
        
        if ([_downloadURLArray count]) {
            downloadState = YES;
            
            
            self.currentDownloadURLString = nil;
            self.currentDownloadURLString = [_downloadURLArray firstObject];
            
            if (![NSString isNull:_currentDownloadURLString]) {
                dispatch_semaphore_signal(semaphore);
                dispatch_set_context(downloadQueue, (__bridge void *)([_downloadURLArray firstObject]));
            }
            
        }else{
        
            self.currentDownloadURLString = @"";
            downloadState = NO;
        }
    });
}

- (void)songDownloadSemaphore{

    dispatch_async(downloadQueue, ^{
        while (1) {
        
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            NSString *urlString = (__bridge NSString *)(dispatch_get_context(downloadQueue));
            NSLog(@"当前下载歌曲的地址为:%@",urlString);
            //下载的具体操作
            
            if ([self songIsExistWithURLString:urlString]) {
                //本地已经存在的时候
                [_downloadURLArray removeObjectAtIndex:0];
                [self sendSemaphore];
                
            }else{
                //本地不存在歌曲的时候 下载
                JOFileDownloadConfig *downloadConfig = [JOFileDownloadConfig new];
                [downloadConfig setFileSavePath:[self songFilePath] fileSaveName:[NSString md5HexDigest:urlString] isCleanExistFile:YES];
                [downloadConfig setRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
                
                [JONetRequestManage startNetRequestWithConfig:downloadConfig requestIdentifier:urlString fileProgressHandler:^(CGFloat progressValue) {
                
//                    NSLog(@"progressValue:%f",progressValue);
                } successHandler:^(NSDictionary *response) {
                    
                    [_downloadURLArray removeObjectAtIndex:0];
                    [self sendSemaphore];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:kMIASongDownloadFinishedNoticeKey object:nil userInfo:@{kMIASongDownloadFinishedNoticeKey:urlString}];
                    
                } failedHandler:^(NSString *failedDescription) {
                    
                    [self sendSemaphore];
                    
                }];
            }
        }
    });
}

#pragma mark - Song File

- (NSString *)songFilePath{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *dirPath = [[PathHelper cacheDir] stringByAppendingPathComponent:kSongCachePath];
    if(![fileManager fileExistsAtPath:dirPath]) {
        [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return dirPath;
}

- (BOOL)songIsExistWithURLString:(NSString *)urlString{

    if (![NSString isNull:urlString]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *dirPath = [[self songFilePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",[NSString md5HexDigest:urlString]]];
        
        return [fileManager fileExistsAtPath:dirPath];
    }else{
    
        [JOFException exceptionWithName:@"MIASongManage exception!" reason:@"urlString is null"];
        return NO;
    }
    
}

- (void)cleanAllSongFileWithCompleteBlock:(void (^)())completeBlock{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *contents = [fileManager contentsOfDirectoryAtPath:[self songFilePath] error:NULL];
        NSEnumerator *enumer = [contents objectEnumerator];
        NSString *filename;
        while ((filename = [enumer nextObject])) {
            [fileManager removeItemAtPath:[[self songFilePath] stringByAppendingPathComponent:filename] error:NULL];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completeBlock) {
                completeBlock();
            }
        });
    });
}

- (NSString *)songPathWithURLString:(NSString *)URLString{

    if ([self songIsExistWithURLString:URLString]) {
        return [[self songFilePath] stringByAppendingString:[NSString md5HexDigest:URLString]];
    }
    return @"";
}

@end
