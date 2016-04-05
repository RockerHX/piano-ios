//
//  HXCommentModel.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCommentModel.h"
#import "FormatTimeHelper.h"


@implementation HXCommentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
       @"nickName": @"nick",
      @"avatarUrl": @"userpic",
     @"createDate": @"addtime"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    _date = [FormatTimeHelper formatTimeWith:_createDate];
}

@end
