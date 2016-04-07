//
//  HXRecordAnchorView.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRecordAnchorView.h"
#import "HXXib.h"


@implementation HXRecordAnchorView

HXXibImplementation

#pragma mark - Event Response
- (IBAction)avatarButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(anchorView:takeAction:)]) {
        [_delegate anchorView:self takeAction:HXRecordAnchorViewActionShowAnchor];
    }
}

@end
