//
//  HXLiveRewardTopModel.h
//  Piano
//
//  Created by miaios on 16/5/20.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"


@interface HXLiveRewardTopModel : NSObject

@property (nonatomic, strong)  NSString *ID;
@property (nonatomic, strong)  NSString *roomID;
@property (nonatomic, strong)  NSString *nickName;
@property (nonatomic, strong)  NSString *avatarUrl;

@property (nonatomic, assign) NSInteger  index;
@property (nonatomic, assign) NSInteger  coinTotal;

@end
