//
//  HXGuestModel.h
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"
#import "HXUserRole.h"

@interface HXGuestModel : NSObject

@property (nonatomic, assign) HXUserRole  role;
@property (nonatomic, strong)   NSString *uID;
@property (nonatomic, strong)   NSString *nickName;

@end
