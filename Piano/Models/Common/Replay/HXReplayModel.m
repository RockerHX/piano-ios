//
//  HXReplayModel.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayModel.h"
#import "FormatTimeHelper.h"


@implementation HXReplayModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
            @"viewCount": @"viewCnt",
           @"createDate": @"createTIme"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    _formatTime = [FormatTimeHelper formatTimeWith:_createDate];
}

@end
