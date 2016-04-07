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

- (IBAction)beautyButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionBeauty];
    }
}

- (IBAction)refreshButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionRefresh];
    }
}

- (IBAction)muteButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionMute];
    }
}

- (IBAction)giftButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionGift];
    }
}

- (IBAction)shareButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomBar:takeAction:)]) {
        [_delegate bottomBar:self takeAction:HXRecordBottomBarActionShare];
    }
}

@end
