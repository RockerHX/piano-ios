//
//  HXDiscoveryTopBar.m
//  Piano
//
//  Created by miaios on 16/4/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryTopBar.h"
#import "HXXib.h"


@implementation HXDiscoveryTopBar

HXXibImplementation

#pragma mark - Event Response
- (IBAction)profileButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(topBar:takeAction:)]) {
        [_delegate topBar:self takeAction:HXDiscoveryTopBarActionProfile];
    }
}

- (IBAction)musicButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(topBar:takeAction:)]) {
        [_delegate topBar:self takeAction:HXDiscoveryTopBarActionMusic];
    }
}

@end
