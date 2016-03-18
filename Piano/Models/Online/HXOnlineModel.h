//
//  HXOnlineModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXOnlineModel : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *uID;
@property (nonatomic, strong)  NSString *streamID;
@property (nonatomic, strong)  NSString *zegoID;
@property (nonatomic, strong)  NSString *zegoToken;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *hlsUrl;
@property (nonatomic, strong)  NSString *rtmpUrl;

@property (nonatomic, assign) NSInteger  status;
@property (nonatomic, assign) NSInteger  onlineCount;
@property (nonatomic, assign) NSInteger  viewCount;
@property (nonatomic, assign) NSInteger  createTime;
@property (nonatomic, assign) NSInteger  addTime;
@property (nonatomic, assign) NSInteger  closeTime;

@end
