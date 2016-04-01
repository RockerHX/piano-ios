//
//  HXProfileModel.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumModel.h"
#import "HXVideoModel.h"
#import "HXReplayModel.h"
#import "HXAttentionModel.h"


typedef NS_ENUM(NSUInteger, HXProfileGender) {
    HXProfileGenderUnknow,
    HXProfileGenderMale,
    HXProfileGenderFemale,
};


@interface HXProfileModel : NSObject

@property (nonatomic, assign)            BOOL  follow;
@property (nonatomic, assign) HXProfileGender  gender;

@property (nonatomic, strong)        NSString *uid;
@property (nonatomic, strong)        NSString *nickName;
@property (nonatomic, strong)        NSString *avatarUrl;
@property (nonatomic, strong)        NSString *summary;

@property (nonatomic, assign)       NSInteger  fansCount;
@property (nonatomic, assign)       NSInteger  followCount;

@property (nonatomic, assign)            BOOL  live;
@property (nonatomic, assign)       NSInteger  liveViewCount;
@property (nonatomic, assign)       NSInteger  liveOnlineCount;
@property (nonatomic, strong)        NSString *liveRoomID;
@property (nonatomic, strong)        NSString *liveTitle;
@property (nonatomic, strong)        NSString *liveCoverUrl;


@property (nonatomic, strong) NSArray<HXAttentionModel *> *attentions;
@property (nonatomic, strong)     NSArray<HXAlbumModel *> *albums;
@property (nonatomic, strong)     NSArray<HXVideoModel *> *videos;
@property (nonatomic, strong)    NSArray<HXReplayModel *> *replays;

@end
