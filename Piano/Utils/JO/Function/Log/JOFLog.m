//
//  JOFLog.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFLog.h"
#import "JOFFileManage.h"

static NSString *const kDeafultLogFileName = @"DefaultLog.log";

@interface JOFLog()

@property (nonatomic, copy) NSString *logFileName;

@end


@implementation JOFLog

- (instancetype)init{

   return [self initWithLogFileName:kDeafultLogFileName];
}

- (instancetype)initWithLogFileName:(NSString *)fileName{
    
    self = [super init];
    
    if (self) {
        
        self.functionDescription = @"JOFLog";
        self.logFileName = nil;
        self.logFileName = fileName;
    }
    return self;
}

+ (JOFLog *)log{

    return [[self alloc] init];
}

+ (JOFLog *)logWithFileName:(NSString *)fileName{

    return [[self alloc] initWithLogFileName:fileName];
}



- (void)writeLogToFileWithContextString:(NSString *)contextString clean:(BOOL)yesOrNo{

    //先判断文件是否存在，若不存在则创建一个
    if (![JOFFileManage fileExistAtDocumentWithFileName:_logFileName]) {
        NSError *error;
        [@"" writeToFile:[JOFFileManage filePathAtDocumentWithFileName:_logFileName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
    if (yesOrNo) {
        NSError *error;
        [contextString writeToFile:[JOFFileManage filePathAtDocumentWithFileName:_logFileName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }else{
        
        NSFileHandle * fileHandle = [NSFileHandle fileHandleForWritingAtPath:[JOFFileManage filePathAtDocumentWithFileName:_logFileName]];
        if(fileHandle == nil){
            return;
        }
        [fileHandle seekToEndOfFile];
        [fileHandle writeData:[[NSString stringWithFormat:@"%@\n\n",contextString] dataUsingEncoding:NSUTF8StringEncoding]];
        [fileHandle closeFile];
    }
}

- (void)writeLogToFileWithContextString:(NSString *)contextString{

    [self writeLogToFileWithContextString:contextString clean:NO];
}

- (void)cleanLog{

    NSError *error;
    [@"" writeToFile:[JOFFileManage filePathAtDocumentWithFileName:_logFileName] atomically:YES encoding:NSUTF8StringEncoding error:&error];
}

- (NSString *)logFilePath{

    return [JOFFileManage filePathAtDocumentWithFileName:_logFileName];
}

@end
