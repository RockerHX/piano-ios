//
//  HXWatcherModel.m
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherModel.h"


@implementation HXWatcherModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
            @"avatarUrl": @"userpic",
            @"signature": @"bio"};
}

@end
