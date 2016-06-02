//
//  MIAProfileModel.m
//  Piano
//
//  Created by 刘维 on 16/5/9.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileModel.h"

@implementation MIAProfileModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    return @{@"uid": @"uID",
//             @"nickName": @"nick",
//             @"avatarUrl": @"userpic",
//             @"summary": @"bio",
//             @"fansCount": @"fansCnt",
//             @"followCount": @"followCnt",
//             @"liveViewCount": @"liveViewCnt",
//             @"liveOnlineCount": @"liveOnlineCnt",
//             @"liveCoverUrl": @"liveRoomCoverUrl",
//             @"attentions": @"followList",
//             @"albums": @"musicAlbum",
//             @"videos": @"video",
//             @"replays": @"replay"};
//}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"musicAlbum": @"MIAAlbumModel",
             @"video": @"MIAVideoModel",
             @"replay": @"MIAReplayModel"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    [_replay enumerateObjectsUsingBlock:^(MIAReplayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.anchorAvatar = _userpic;
    }];
}

@end
