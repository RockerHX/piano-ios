//
//  HXPreviewLiveTopBar.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPreviewLiveTopBar.h"
#import "HXXib.h"


@implementation HXPreviewLiveTopBar

HXXibImplementation

#pragma mark - Event Response
- (IBAction)beautyButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(topBar:takeAction:)]) {
        [_delegate topBar:self takeAction:HXPreviewLiveTopBarActionBeauty];
    }
}

- (IBAction)changeButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(topBar:takeAction:)]) {
        [_delegate topBar:self takeAction:HXPreviewLiveTopBarActionChange];
    }
}

- (IBAction)closeButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(topBar:takeAction:)]) {
        [_delegate topBar:self takeAction:HXPreviewLiveTopBarActionColse];
    }
}

@end
