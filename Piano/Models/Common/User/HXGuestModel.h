//
//  HXGuestModel.h
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

typedef NS_ENUM(NSInteger, HXUserRole) {
	HXUserRoleGuest = 0,
	HXUserRoleNormal = 1,
	HXUserRoleAnchor = 2,
};

@interface HXGuestModel : NSObject

@property (nonatomic, assign) HXUserRole  role;
@property (nonatomic, strong)   NSString *uID;
@property (nonatomic, strong)   NSString *nickName;

@end
