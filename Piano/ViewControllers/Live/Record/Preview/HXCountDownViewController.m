//
//  HXCountDownViewController.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCountDownViewController.h"


@interface HXCountDownViewController ()
@end


@implementation HXCountDownViewController {
    NSTimer *_timer;
    NSUInteger _count;
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

- (void)dealloc {
    [_timer invalidate];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)startCountDown {
    _count = 3;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
}

#pragma mark - Private Methods
- (void)countDown {
    if (_count < 1) {
        [_timer invalidate];
        
        if (_delegate && [_delegate respondsToSelector:@selector(countDownFinished)]) {
            [_delegate countDownFinished];
        }
        return;
    }
    
    _count--;
    if (_count == 0) {
        _countLabel.text = @"Live";
    } else {
        _countLabel.text = @(_count).stringValue;
    }
}

@end
