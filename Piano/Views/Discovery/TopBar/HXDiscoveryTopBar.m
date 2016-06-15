//
//  HXDiscoveryTopBar.m
//  Piano
//
//  Created by miaios on 16/4/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryTopBar.h"
#import "HXXib.h"
#import "YYImage.h"
#import "BlocksKit+UIKit.h"


@implementation HXDiscoveryTopBar

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    __weak __typeof__(self)weakSelf = self;
    [_playerEntry bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf musicButtonPressed];
    }];
}

- (void)viewConfigure {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"D-MusicEntry" ofType:@"gif"]];
    YYImage *image = [YYImage imageWithData:data];
    _playerEntry.image = image;
}

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
