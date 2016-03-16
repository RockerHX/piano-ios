//
//  HXCaptchButton.m
//
//  Created by ShiCang on 14/12/31.
//  Copyright (c) 2014年 ShiCang. All rights reserved.
//

#import "HXCaptchButton.h"

typedef BOOL(^StartBlock)(HXCaptchButton *);
typedef void(^EndBlock)(HXCaptchButton *);

static NSTimeInterval TimeOutFlag = 1;
static NSTimeInterval TimeDuration = 60;

static NSString *TextPrompt = @"获取验证码";

@implementation HXCaptchButton {
    NSTimeInterval _timeOut;
    NSTimer *_countDownTimer;
    
    StartBlock _startBlock;
    EndBlock _endBlock;
    HXSecurityType _type;
}

#pragma mark - Init Methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initConfigure];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initConfigure];
    }
    return self;
}

#pragma mark - Config Methods
- (void)initConfigure {
    _type     = HXSecurityTypeMessage;
    _duration = TimeDuration;
}

#pragma mark - Parent Methods
- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event {
    [self startCountDown];
}

#pragma mark - Private Methods
- (void)startCountDown {
    if (self.enabled) {
        if (_startBlock) {
            if (_startBlock(self)) {
                _timeOut = _duration;
                [self setTitle:[NSString stringWithFormat:@" %@s 重新获取 ", @(_timeOut)] forState:UIControlStateNormal];
                _countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
                self.enabled = NO;
            }
        }
    }
}

/**
 *  倒计时刷新方法
 */
- (void)timeFireMethod {
    _timeOut--;
    [self setTitle:[NSString stringWithFormat:@" %@s 重新获取 ", @(_timeOut)] forState:UIControlStateNormal];
    
    if(_timeOut < TimeOutFlag){
        [self stop];
        _type = HXSecurityTypeCall;
    }
}

#pragma mark - Public Methods
- (void)timingStart:(BOOL(^)(HXCaptchButton *button))start end:(void(^)(HXCaptchButton *button))end {
    _startBlock = start;
    _endBlock = end;
}

- (void)stop {
    self.enabled = YES;
    [_countDownTimer invalidate];
    
    [self setTitle:TextPrompt forState:UIControlStateNormal];
    
    if (_endBlock) {
        _endBlock(self);
    }
}

#pragma mark - Delloc Methods
- (void)dealloc {
    // 如果View被移除，定时器需要废除掉
    [_countDownTimer invalidate];
}

@end
