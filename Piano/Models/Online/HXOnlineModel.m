//
//  HXOnlineModel.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineModel.h"


@implementation HXOnlineModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"nickName": @"nick",
            @"avatarUrl": @"userpic",
          @"onlineCount": @"onlineCnt",
            @"viewCount": @"viewCnt"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    if (_live) {
        _ID = _roomID;
        _type = HXOnlineTypeLive;
        return;
    }
    
    _ID = @(_itemID).stringValue;
    switch (_itemType) {
        case 1: {
            _type = HXOnlineTypeNewEntry;
            break;
        }
        case 2: {
            _type = HXOnlineTypeVideo;
            break;
        }
        case 3: {
            _type = HXOnlineTypeReplay;
            break;
        }
    }
}

@end
