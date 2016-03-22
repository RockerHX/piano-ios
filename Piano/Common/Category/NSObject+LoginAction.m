//
//  NSObject+LoginAction.m
//  mia
//
//  Created by miaios on 16/2/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "NSObject+LoginAction.h"

NSString *const kLoginNotification   = @"kLoginNotification";
NSString *const kLogoutNotification  = @"kLogoutNotification";

@implementation NSObject (LoginAction)

- (void)shouldLogin {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginNotification object:nil];
}

- (void)shouldLogout {
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:nil];
}

@end
