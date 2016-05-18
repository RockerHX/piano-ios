//
//  HXAlbumModel.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumModel.h"


@implementation HXAlbumModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"nickName": @"nick",
    @"rewardCount": @"backTotal"};
}

@end
