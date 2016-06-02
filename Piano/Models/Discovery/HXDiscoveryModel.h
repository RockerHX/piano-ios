//
//  HXDiscoveryModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


typedef NS_ENUM(NSUInteger, HXDiscoveryModelType) {
    HXDiscoveryModelTypeAnchor,
    HXDiscoveryModelTypeLive,
    HXDiscoveryModelTypeProfile,
};


@class HXReplayModel;


@interface HXDiscoveryModel : NSObject

@property (nonatomic, strong)  NSString *uID;
@property (nonatomic, strong)  NSString *roomID;
@property (nonatomic, strong)  NSString *liveDate;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *anchorAvatar;
@property (nonatomic, strong)  NSString *coverUrl;
@property (nonatomic, strong)  NSString *videoUrl;
@property (nonatomic, strong)  NSString *coverColor;
@property (nonatomic, assign) NSInteger  duration;
@property (nonatomic, assign) NSInteger  videoUpdated;
@property (nonatomic, assign) NSInteger  albumUpdated;


@property (nonatomic, assign) HXDiscoveryModelType  type;
@property (nonatomic, assign) BOOL  showVideoIcon;
@property (nonatomic, assign) BOOL  showAlbumIcon;

+ (instancetype)createWithReplayModel:(id)model;

@end
