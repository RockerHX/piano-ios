//
//  HXOnlineModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


typedef NS_ENUM(NSUInteger, HXOnlineType) {
    HXOnlineTypeLive,
    HXOnlineTypeReplay,
    HXOnlineTypeNewEntry,
    HXOnlineTypeVideo,
};


@interface HXOnlineModel : NSObject

@property (nonatomic, assign, readonly) HXOnlineType  type;
@property (nonatomic, strong, readonly)     NSString *ID;

@property (nonatomic, strong)  NSString *uID;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *avatarUrl;
@property (nonatomic, strong)  NSString *coverUrl;

@property (nonatomic, assign) NSInteger  onlineCount;
@property (nonatomic, assign) NSInteger  viewCount;

@property (nonatomic, assign) NSInteger  itemID;
@property (nonatomic, assign) NSInteger  itemType;
@property (nonatomic, assign) NSInteger  live;
@property (nonatomic, assign) NSInteger  liveDate;
@property (nonatomic, strong)  NSString *roomID;

@end
