//
//  HXDiscoveryModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@class HXReplayModel;


@interface HXDiscoveryModel : NSObject

@property (nonatomic, assign)      BOOL  anchor;
@property (nonatomic, assign)      BOOL  live;
@property (nonatomic, assign)      BOOL  videoUpdated;
@property (nonatomic, assign)      BOOL  albumUpdated;

@property (nonatomic, strong)  NSString *uID;
@property (nonatomic, strong)  NSString *roomID;
@property (nonatomic, strong)  NSString *liveDate;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *coverUrl;
@property (nonatomic, strong)  NSString *videoUrl;
@property (nonatomic, strong)  NSString *coverColor;
@property (nonatomic, assign) NSInteger  duration;

+ (instancetype)createWithReplayModel:(id)model;

@end
