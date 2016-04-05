//
//  HXSongModel.m
//  Piano
//
//  Created by miaios on 16/4/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSongModel.h"


@implementation HXSongModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    NSInteger second = _duration / 1000;
    NSInteger minute = second / 60;
    _durationPrompt = [NSString stringWithFormat:@"%02zd:%02zd", minute, (second % 60)];
}

@end
