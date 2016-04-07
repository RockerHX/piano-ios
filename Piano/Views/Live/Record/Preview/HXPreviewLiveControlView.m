//
//  HXPreviewLiveControlView.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPreviewLiveControlView.h"
#import "HXXib.h"


@implementation HXPreviewLiveControlView

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    _container.backgroundColor = [UIColor clearColor];
}

#pragma mark - Event Response
- (IBAction)friendsCycleButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlView:takeAction:)]) {
        [_delegate controlView:self takeAction:HXPreviewLiveControlViewActionFriendsCycle];
    }
}

- (IBAction)wechatButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlView:takeAction:)]) {
        [_delegate controlView:self takeAction:HXPreviewLiveControlViewActionWeChat];
    }
}

- (IBAction)weiboButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlView:takeAction:)]) {
        [_delegate controlView:self takeAction:HXPreviewLiveControlViewActionWeiBo];
    }
}

- (IBAction)startLiveButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(controlView:takeAction:)]) {
        [_delegate controlView:self takeAction:HXPreviewLiveControlViewActionStartLive];
    }
}

@end
