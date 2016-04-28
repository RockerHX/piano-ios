//
//  HXDiscoveryModel.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryModel.h"
#import "HXReplayModel.h"


@implementation HXDiscoveryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick"};
}

#pragma mark - Init Methods
+ (instancetype)createWithReplayModel:(HXReplayModel *)replayModel {
    NSDictionary *keyValues = [replayModel mj_keyValues];
    HXDiscoveryModel *model = [HXDiscoveryModel mj_objectWithKeyValues:keyValues];
    model.videoUrl = replayModel.replayUrl;
    return model;
}

@end
