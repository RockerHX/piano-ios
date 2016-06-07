//
//  HXAccountModel.h
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UMengSocialCOM/UMSocial.h>


@interface HXAccountModel : NSObject

@property (nonatomic, strong) UMSocialAccountEntity *sdkUser;

@property (nonatomic, copy)   NSString *mobile;
@property (nonatomic, copy)   NSString *password;

@end
