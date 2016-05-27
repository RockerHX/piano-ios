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
    [self download:nil];
}

#pragma mark - Property
- (BOOL)status {
    return (_iconData && _animationData);
}

#pragma mark - Public Methods
- (void)download:(void(^)(HXGiftModel *gift))completed {
    [[HXDownLoadCache cache] downLoadWithURL:[NSURL URLWithString:_iconUrl] completionHandler:^(HXDownLoadCache * _Nonnull cache, NSData * _Nonnull data, NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
        _iconData = data;
        [cache downLoadWithURL:[NSURL URLWithString:_animateUrl] completionHandler:^(HXDownLoadCache * _Nonnull cache, NSData * _Nonnull data, NSURLResponse * _Nonnull response, NSError * _Nonnull error) {
            _animationData = data;
            if (completed) {
                completed(self);
            }
        }];
    }];
}

@end
