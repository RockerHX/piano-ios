//
//  HXLiveModel.m
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveModel.h"
#import "HXOnlineModel.h"


@implementation HXLiveModel

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _userID = @"user999";
    _userName = @"992190999";
}

#pragma mark - Public Methods
- (instancetype)initWithUserID:(NSString *)userID userName:(NSString *)userName {
    self = [self init];
    if (self) {
        _userID = userID;
        _userName = userName;
    }
    return self;
}

- (instancetype)initWithOnlineModel:(HXOnlineModel *)model {
    self = [self init];
    if (self) {
        _type = model.type;
        _roomNumber = [model.ID integerValue];
//        _roomToken = model.zegoToken;
//        _streamID = model.streamID;
    }
    return self;
}

@end
