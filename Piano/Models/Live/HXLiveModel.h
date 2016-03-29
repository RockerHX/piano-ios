//
//  HXLiveModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXLiveModel : NSObject

@property(nonatomic, strong) NSString *uID;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *nickName;
@property(nonatomic, strong) NSString *avatarUrl;

@property(nonatomic, strong) NSString *hlsUrl;
@property(nonatomic, strong) NSString *rtmpUrl;

@property (nonatomic, assign) NSInteger  zegoID;
@property (nonatomic, assign) NSInteger  zegoToken;
@property (nonatomic, assign) NSInteger  streamID;

@property (nonatomic, assign) NSInteger  onlineCount;
@property (nonatomic, assign) NSInteger  viewCount;

@end
