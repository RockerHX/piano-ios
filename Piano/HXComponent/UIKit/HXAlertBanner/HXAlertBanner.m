//
//  HXAlertBanner.m
//  mia
//
//  Created by miaios on 15/10/21.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXAlertBanner.h"
#import "AppDelegate.h"

typedef void(^BLOCK)(void);

static CGFloat BannerHeight = 67.0f;

@implementation HXAlertBanner {
    BLOCK _tapBlock;
}

#pragma mark - Class Methods
+ (instancetype)showWithMessage:(NSString *)message tap:(void(^)(void))tap {
    HXAlertBanner *banner = [[[NSBundle mainBundle] loadNibNamed:@"HXAlertBanner" owner:self options:nil] firstObject];
    [banner showWithMessage:message tap:tap];
    return banner;
}

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initConfig];
    [self viewConfig];
}

#pragma mark - Config Methods
- (void)initConfig {
    _height = BannerHeight;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self addGestureRecognizer:tap];
}

- (void)viewConfig {
    
}

#pragma mark - Event Response
- (void)tapGesture {
    if (_tapBlock) {
        _tapBlock();
    }
}

#pragma mark - Public Methods
- (void)showWithMessage:(NSString *)message tap:(void(^)(void))tap {
    _tapBlock = tap;
    _messageLabel.text = message;
    [self show];
}

- (void)hidden {
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.6f animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.frame = (CGRect){
            0.0f, -strongSelf.height,
            strongSelf.frame.size.width,
            strongSelf.height
        };
    } completion:^(BOOL finished) {
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
    }];
}

#pragma mark - Private Methods
- (void)show {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
    self.frame = (CGRect){
        0.0f, -_height,
        mainWindow.frame.size.width,
        _height
    };
    [mainWindow addSubview:self];
    __weak __typeof__(self)weakSelf = self;
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        strongSelf.frame = (CGRect){
            0.0f, 0.0f,
            strongSelf.frame.size.width,
            strongSelf.height
        };
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            __strong __typeof__(self)strongSelf = weakSelf;
            [strongSelf hidden];
        });
    }];
}

@end
