//
//  NSObject+LoginAction.h
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString *const kLoginNotification;
FOUNDATION_EXPORT NSString *const kLogoutNotification;

@interface NSObject (LoginAction)

- (void)shouldLogin;
- (void)shouldLogout;

@end
