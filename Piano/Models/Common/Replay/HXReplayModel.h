//
//  HXReplayModel.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXReplayModel : NSObject

@property (nonatomic, assign) NSInteger  viewCount;
@property (nonatomic, assign) NSInteger  createDate;

@property (nonatomic, strong)  NSString *title;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *coverUrl;
@property (nonatomic, strong)  NSString *formatTime;

@end
