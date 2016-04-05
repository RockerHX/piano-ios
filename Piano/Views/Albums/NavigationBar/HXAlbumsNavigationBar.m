//
//  HXAlbumsNavigationBar.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsNavigationBar.h"
#import "HXXib.h"


@implementation HXAlbumsNavigationBar

HXXibImplementation

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(navigationBar:takeAction:)]) {
        [_delegate navigationBar:self takeAction:HXAlbumsNavigationBarActionBack];
    }
}

@end
