//
//  HXMeNavigationBar.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeNavigationBar.h"
#import "HXXib.h"


@implementation HXMeNavigationBar

HXXibImplementation

#pragma mark - Event Reponse
- (IBAction)settingButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(navigationBar:action:)]) {
        [_delegate navigationBar:self action:HXMeNavigationBarActionSetting];
    }
}

@end
