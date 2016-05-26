//
//  HXLiveModel.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"
#import "HXAlbumModel.h"


@interface HXLiveModel : NSObject

@property (nonatomic, strong)  NSString *uID;
@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *avatarUrl;

@property (nonatomic, strong)  NSString *hlsUrl;
@property (nonatomic, strong)  NSString *rtmpUrl;

@property (nonatomic, assign) NSInteger  zegoID;
@property (nonatomic, assign) NSInteger  zegoToken;
@property (nonatomic, assign) NSInteger  streamID;
@property (nonatomic, strong)  NSString *channelID;
@property (nonatomic, strong)  NSString *streamAlias;

@property (nonatomic, strong)  NSString *roomID;
@property (nonatomic, strong)  NSString *shareUrl;
@property (nonatomic, strong)  NSString *shareTitle;
@property (nonatomic, strong)  NSString *shareContent;

@property (nonatomic, assign) NSInteger  onlineCount;
@property (nonatomic, assign) NSInteger  viewCount;

@property (nonatomic, strong) HXAlbumModel *album;

@end
