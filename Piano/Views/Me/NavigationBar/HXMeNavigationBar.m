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

#pragma mark - Public Methods
- (void)showBottomLine:(BOOL)show {
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _bottomLine.alpha = (show ? 1.0 : 0.0f);
    } completion:nil];
}

@end
