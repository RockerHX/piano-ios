//
//  JOFException.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/26.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOFException.h"
#import "JOFLog.h"

static NSString *const kDeafultExceptionLogFileName = @"ExceptionLog.log";

@implementation JOFException

+ (void)exceptionWithName:(NSString *)exceptionName reason:(NSString *)reason saveState:(BOOL)yesOrNo{

    NS_DURING
    [JOFException raiseExceptionWithName:exceptionName reason:reason];
    NS_HANDLER
    if (yesOrNo) {
        [[JOFLog logWithFileName:kDeafultExceptionLogFileName] writeLogToFileWithContextString:[NSString stringWithFormat:@"%@------%@",localException.name,localException.reason]];
    }
    NSLog(@"ExceptionName:%@ Reason:%@",localException.name,localException.reason);
    
    NS_ENDHANDLER
}

+ (void)exceptionWithName:(NSString *)exceptionName reason:(NSString *)reason{

    [JOFException exceptionWithName:exceptionName reason:reason saveState:NO];
}

+ (void)raiseExceptionWithName:(NSString *)exceptionName reason:(NSString *)reason{

    return [NSException raise:exceptionName format:@"%@",reason];
}

+ (void)raiseExceptionWithName:(NSString *)exceptionName{

    return [JOFException raiseExceptionWithName:exceptionName reason:@""];
}

+ (NSException *)createExceptionWithName:(NSString *)exceptionName
                                  reason:(NSString *)reason
                                userInfo:(NSDictionary *)userInfo{

    return [[NSException alloc] initWithName:exceptionName reason:reason userInfo:userInfo];
}

+ (NSException *)createExceptionWithName:(NSString *)exceptionName reason:(NSString *)reason{

    return [JOFException createExceptionWithName:exceptionName reason:reason userInfo:nil];
}

+ (NSException *)createExceptionWithName:(NSString *)exceptionName{

    return [JOFException createExceptionWithName:exceptionName reason:@"" userInfo:nil];
}

@end
