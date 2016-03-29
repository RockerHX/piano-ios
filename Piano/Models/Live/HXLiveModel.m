//
//  HXLiveModel.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveModel.h"


@implementation HXLiveModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
            @"avatarUrl": @"userpic",
          @"onlineCount": @"onlineCnt",
            @"viewCount": @"viewCnt"};
}

@end
