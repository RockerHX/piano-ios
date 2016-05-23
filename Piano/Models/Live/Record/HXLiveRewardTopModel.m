//
//  HXLiveRewardTopModel.m
//  Piano
//
//  Created by miaios on 16/5/20.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveRewardTopModel.h"


@implementation HXLiveRewardTopModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"nickName": @"nick",
      @"avatarUrl": @"userpic",
      @"coinTotal": @"mcoin"};
}

@end
