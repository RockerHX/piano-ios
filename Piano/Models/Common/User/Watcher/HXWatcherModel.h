//
//  HXWatcherModel.h
//  Piano
//
//  Created by miaios on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HXCommentModel;


@interface HXWatcherModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *avatarUrl;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *signature;

+ (instancetype)instanceWithComment:(HXCommentModel *)comment;

@end
