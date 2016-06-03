//
//  HXDiscoveryModel.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryModel.h"
#import "HXReplayModel.h"
#import "MIAReplayModel.h"


@implementation HXDiscoveryModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
          @"onlineCount": @"onlineCnt"};
}

#pragma mark - Init Methods
+ (instancetype)createWithReplayModel:(id)model {
    HXDiscoveryModel *discoveryModel = nil;
    if ([model isKindOfClass:[HXReplayModel class]]) {
        HXReplayModel *replayModel = model;
        NSDictionary *keyValues = [replayModel mj_keyValues];
        discoveryModel = [HXDiscoveryModel mj_objectWithKeyValues:keyValues];
        discoveryModel.videoUrl = replayModel.replayUrl;
    } else if ([model isKindOfClass:[MIAReplayModel class]]) {
        MIAReplayModel *replayModel = model;
        discoveryModel              = [HXDiscoveryModel new];
        discoveryModel.roomID       = replayModel.roomID;
        discoveryModel.anchorAvatar = replayModel.anchorAvatar;
        discoveryModel.nickName     = replayModel.nick;
        discoveryModel.coverUrl     = replayModel.coverUrl;
        discoveryModel.videoUrl     = replayModel.replayUrl;
        discoveryModel.duration     = replayModel.duration;
    }
    return discoveryModel;
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    _showVideoIcon = (_videoUpdated == 1) ? YES : NO;
    _showAlbumIcon = (_albumUpdated == 1) ? YES : NO;
}

@end
