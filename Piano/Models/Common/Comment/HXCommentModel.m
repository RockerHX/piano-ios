//
//  HXCommentModel.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCommentModel.h"


@implementation HXCommentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"nickName": @"nick",
      @"avatarUrl": @"userpic"};
}

@end
