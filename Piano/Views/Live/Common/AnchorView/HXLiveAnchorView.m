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

#pragma mark - Property
- (void)setAttented:(BOOL)attented {
    _attented = attented;
    [_attentionButton setImage:[UIImage imageNamed:(attented ? @"L-AttentedIcon" : @"L-AddAttentionIcon")] forState:UIControlStateNormal];
}

- (void)setOwnside:(BOOL)ownside {
    _ownside = ownside;
    if (ownside) {
        _attentionButtonWidthConstraint.constant = 0.0f;
    }
}

- (void)setReplay:(BOOL)replay {
    _replay = replay;
    if (replay) {
        _countPromptLabel.text = @"观看人数";
    }
}

#pragma mark - Event Response
- (IBAction)avatarButtonPressed {
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
