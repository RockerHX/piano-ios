//
//  HXRecordBottomBar.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRecordBottomBar.h"
#import "HXXib.h"


@implementation HXRecordBottomBar

HXXibImplementation

#pragma mark - Event Response
- (IBAction)commentButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionComment];
    }
}

- (IBAction)forwardingButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionForwarding];
    }
}

@end
