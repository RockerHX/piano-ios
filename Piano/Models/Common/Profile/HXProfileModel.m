//
//  HXProfileModel.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileModel.h"


@implementation HXProfileModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"uid": @"uID",
        @"nickName": @"nick",
       @"avatarUrl": @"userpic",
         @"summary": @"bio",
       @"fansCount": @"fansCnt",
     @"followCount": @"followCnt",
   @"liveViewCount": @"liveViewCnt",
 @"liveOnlineCount": @"liveOnlineCnt",
    @"liveCoverUrl": @"liveRoomCoverUrl",
      @"attentions": @"followList",
          @"albums": @"musicAlbum",
          @"videos": @"video",
         @"replays": @"replay"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"attentions": @"HXAttentionModel",
                 @"albums": @"HXAlbumModel",
                 @"videos": @"HXVideoModel",
                @"replays": @"HXReplayModel"};
}

@end
