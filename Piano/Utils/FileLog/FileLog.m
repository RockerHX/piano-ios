//
//  FileLog.m
//
//
//  Created by linyehui on 2015/10/24.
//  Copyright (c) 2015年 linyehui. All rights reserved.
//

#import "FileLog.h"
#import "PathHelper.h"

const static unsigned long long kMaxLogFileSize		= 1024 * 100;	// 单位字节，Log文件大小，超过这个大小会删除文件
const static unsigned long long kLatestLogSize 		= 1024 * 20;	// 单位字节，读取的Log长度
const static long kLogTimesForCheckFileSize			= 1000;			// 单次生命周期内写log超过这个次数就检查下文件大小是否超过文件大小

@implementation FileLog {
	NSString		*_logFilePath;
	NSFileHandle 	*_writeFileHandle;
	long			_logTimes;
}

+ (id)standard{
	static FileLog *aFileLog = nil;
	static dispatch_once_t predicate;
	dispatch_once(&predicate, ^{
		aFileLog = [[self alloc] init];
	});
	return aFileLog;
}

- (id) init {
    if (self == [super init]) {
		_logFilePath = [PathHelper logFileName];

		if (![[NSFileManager defaultManager] fileExistsAtPath:_logFilePath]) {
			[[NSFileManager defaultManager] createFileAtPath:_logFilePath contents:nil attributes:nil];
		} else {
			[self checkFileSize];
		}

		_writeFileHandle = [NSFileHandle fileHandleForWritingAtPath:_logFilePath];
        [_writeFileHandle seekToEndOfFile];
    }
    
    return self;
}

- (void)log:(NSString *)format, ... {
    va_list ap;
    va_start(ap, format);

    NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
	NSDate *currentDate = [NSDate date];
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
	NSString *dateString = [dateFormatter stringFromDate:currentDate];
	NSString *writeString = [NSString stringWithFormat:@"%@ %@\n", dateString, message];

	NSLog(@"%@", message);
	
    [_writeFileHandle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
    [_writeFileHandle synchronizeFile];

	_logTimes++;
	if (_logTimes > kLogTimesForCheckFileSize) {
		[self checkFileSize];
		_logTimes = 0;
	}
}

- (NSData *)latestLogs {
	NSFileHandle *readFileHandle = [NSFileHandle fileHandleForReadingAtPath:_logFilePath];
	if (!readFileHandle) {
		return nil;
	}

	unsigned long long fileSize = [self logFieSize];
	unsigned long long fileOffset = 0;
	if (fileSize > kLatestLogSize) {
		fileOffset = fileSize - kLatestLogSize;
	}
	NSLog(@"%llu, %llu, %llu", [self logFieSize], kLatestLogSize, fileOffset);

	[readFileHandle seekToFileOffset:fileOffset];
	NSData *logData = [readFileHandle readDataToEndOfFile];
	[readFileHandle closeFile];

	return logData;
}

#pragma mark - Private Methods

- (unsigned long long)logFieSize {
	NSError* error;
	NSDictionary* fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:_logFilePath error:&error];
	NSNumber *fileSize = (NSNumber*)[fileAttributes objectForKey: NSFileSize];
	NSLog(@"log file size: %llu", [fileSize unsignedLongLongValue]);

	return [fileSize unsignedLongLongValue];
}

- (void)checkFileSize {
	if ([self logFieSize] > kMaxLogFileSize) {
		NSError *error;
		[[NSFileManager defaultManager] removeItemAtPath:_logFilePath error:&error];
		[[NSFileManager defaultManager] createFileAtPath:_logFilePath contents:nil attributes:nil];
	}
}

@end
