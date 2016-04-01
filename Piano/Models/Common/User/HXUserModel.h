//
//  HXUserModel.h
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"
#import "HXGuestModel.h"

@interface HXUserModel : NSObject

@property (nonatomic, assign) NSInteger  notifyCount;

@property (nonatomic, assign) HXUserRole  role;
@property (nonatomic, strong)   NSString *uID;
@property (nonatomic, strong)   NSString *token;
@property (nonatomic, strong)   NSString *nickName;
@property (nonatomic, strong)   NSString *avatarUrl;
@property (nonatomic, strong)   NSString *notifyAvatar;

@end
