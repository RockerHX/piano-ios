//
//  HXAlbumsBottomBar.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsBottomBar.h"
#import "HXXib.h"


@implementation HXAlbumsBottomBar

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)]];
}

#pragma mark - Event Reponse
- (void)tapGesture {
    if (_delegate && [_delegate respondsToSelector:@selector(bottomView:takeAction:)]) {
        [_delegate bottomView:self takeAction:HXAlbumsBottomBarActionComment];
    }
}

@end
