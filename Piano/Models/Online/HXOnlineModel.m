//
//  HXOnlineModel.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineModel.h"


@implementation HXOnlineModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"nickName": @"nick",
    @"onlineCount": @"onlineCnt",
      @"viewCount": @"viewCnt"};
}

@end
