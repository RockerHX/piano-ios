//
//  HXLiveModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineModel.h"

@interface HXLiveModel : NSObject

@property(nonatomic, strong) NSString *roomType;
@property(nonatomic, strong) NSString *roomTitle;
@property(nonatomic, strong) NSString *createTime;
@property(nonatomic, strong) NSString *endTime;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *userID;
@property(nonatomic, strong) NSString *userPic;
@property(nonatomic, strong) NSString *publisherName;
@property(nonatomic, strong) NSString *publisherID;
@property(nonatomic, strong) NSString *publisherPic;
@property(nonatomic, strong) NSString *replayPath;
@property(nonatomic, strong) NSString *coverPath;

@property(nonatomic, assign) NSInteger  roomNumber;
@property(nonatomic, assign) NSInteger  roomToken;
@property(nonatomic, assign) NSInteger  streamID;

@property(nonatomic, assign) HXOnlineType  type;

- (instancetype)initWithUserID:(NSString *)userID userName:(NSString *)userName;
- (instancetype)initWithOnlineModel:(HXOnlineModel *)model;

@end
