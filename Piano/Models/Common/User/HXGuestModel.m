//
//  HXGuestModel.m
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXGuestModel.h"


@implementation HXGuestModel

MJCodingImplementation

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
                 @"type": @"utype"};
}

- (void)mj_objectDidFinishConvertingToKeyValues {
    _uID = [NSString stringWithFormat:@"%@", _uID];
}

@end
