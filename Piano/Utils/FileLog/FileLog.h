//
//  FileLog.h
//
//
//  Created by linyehui on 2015/10/24.
//  Copyright (c) 2015年 linyehui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileLog : NSObject

+ (id)standard;

- (void)log:(NSString *)format, ...;
- (NSData *)latestLogs;

@end
