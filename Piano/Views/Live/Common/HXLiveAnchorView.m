//
//  HXLiveAnchorView.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveAnchorView.h"
#import "HXXib.h"


@implementation HXLiveAnchorView

HXXibImplementation

#pragma mark - Event Response
- (IBAction)anchorAvatarPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(anchorView:takeAction:)]) {
        [_delegate anchorView:self takeAction:HXLiveAnchorViewActionShowAnchor];
    }
}

- (IBAction)attentionButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(anchorView:takeAction:)]) {
        [_delegate anchorView:self takeAction:HXLiveAnchorViewActionAttention];
    }
}

@end
