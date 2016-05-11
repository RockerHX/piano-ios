//
//  JOFFileManage.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFFileManage.h"

@implementation JOFFileManage

+ (nullable NSString *)documentPath{

   return [NSHomeDirectory() stringByAppendingFormat:@"/Documents/"];
}

+ (nullable NSString *)tempPath{

    return NSTemporaryDirectory();
}

+ (nullable NSString *)filePathAtDocumentWithFileName:(nullable NSString *)fileName{

    JOArgumentsCAssertNotNil(fileName, @"JOFFileManage : fileAtDocumentWithFileName fileName is nil");
    if (fileName) {
        return [[JOFFileManage documentPath] stringByAppendingString:fileName];//[NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@",fileName];
    }
    
    return [JOFFileManage documentPath];
    
}

+ (BOOL)fileExistAtDocumentWithFileName:(nullable NSString *)fileName{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:[JOFFileManage filePathAtDocumentWithFileName:fileName]];
}

+ (BOOL)fileExistAtFilePath:(nullable NSString *)filePath{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:filePath];
}

+ (BOOL)createFileAtDocumentWithFileName:(nullable NSString *)fileName isRemoveExistFile:(BOOL)yesOrNo{

    if ([JOFFileManage fileExistAtDocumentWithFileName:fileName]) {
        //存在
        if (yesOrNo) {
            //删除
            [JOFFileManage removeFileAtDocumentWithFileName:fileName];
        }else{
            //不删除
            return YES;
        }
    }
    
    NSError *createFileError;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager createDirectoryAtPath:[JOFFileManage documentPath] withIntermediateDirectories:NO attributes:nil error:&createFileError];
    
    if (createFileError) {
        //抛出创建文件失败的异常
        return NO;
    }
    
    return YES;
}

+ (BOOL)removeFileAtDocumentWithFileName:(nullable NSString *)fileName{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *removeFileError;
    [fileManager removeItemAtPath:[JOFFileManage filePathAtDocumentWithFileName:fileName] error:&removeFileError];
    
    if (removeFileError) {
        //抛出异常
        return NO;
    }
    
    return YES;
}

+ (nullable NSArray<NSString *> *)allFileNameAtDocument{

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *fileError;
    return [fileManager contentsOfDirectoryAtPath:[JOFFileManage documentPath] error:&fileError];
}

@end
