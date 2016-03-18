//
//  NSString+IsNull.m
//
//  Created by linyehui on 14-8-7.
//
//

#import "NSString+IsNull.h"

@implementation NSString (IsNull)

/**
 *  判断NSString是否为空
 *
 */
+(BOOL)isNull:(NSString *)str{
    if(str == nil || [@"" isEqualToString:str] || [str isKindOfClass:[NSNull class]]){
        return true;
    }
    return false;
}

@end
