//
//  HXWatcherModel.h
//  Piano
//
//  Created by miaios on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HXCommentModel;
@class HXLiveModel;


@interface HXWatcherModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *signature;

+ (instancetype)instanceWithComment:(HXCommentModel *)comment;
+ (instancetype)instanceWithLiveModel:(HXLiveModel *)liveModel;

@end
