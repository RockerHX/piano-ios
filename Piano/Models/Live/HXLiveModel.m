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
- (instancetype)initWithOnlineModel:(HXOnlineModel *)model {
    self = [self init];
    if (self) {
        _roomNumber = model.zegoID;
        _roomToken = model.zegoToken;
        _streamID = model.streamID;
    }
    return self;
}

@end
