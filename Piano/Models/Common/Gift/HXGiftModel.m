//
//  HXGiftModel.m
//  Piano
//
//  Created by miaios on 16/5/19.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXGiftModel.h"
#import "HXDownLoadCache.h"


@implementation HXGiftModel

#pragma mark - Parse Methods
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id",
         @"prompt": @"description"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    [self download];
}

#pragma mark - Property
- (BOOL)status {
    return (_iconData && _animationData);
}

#pragma mark - Public Methods
- (void)download {
    [[HXDownLoadCache cache] downLoadWithURL:[NSURL URLWithString:_iconUrl] completionHandler:^(NSData * _Nullable data, NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        _iconData = data;
    }];
    [[HXDownLoadCache cache] downLoadWithURL:[NSURL URLWithString:_animateUrl] completionHandler:^(NSData * _Nullable data, NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        _animationData = data;
    }];
}

@end
