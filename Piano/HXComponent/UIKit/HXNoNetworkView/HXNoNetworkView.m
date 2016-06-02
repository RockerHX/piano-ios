//
//  HXNoNetworkView.m
//  mia
//
//  Created by miaios on 15/10/19.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXNoNetworkView.h"
#import "AppDelegate.h"


typedef void(^BLOCK)(void);


@interface HXNoNetworkView () {
    BLOCK _showBlock;
    BLOCK _playBlock;
}
@end


@implementation HXNoNetworkView

#pragma mark - Init Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self viewConfigure];
}

#pragma mark - Config Methods
- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
+ (instancetype)showOnViewController:(UIViewController *)viewController show:(void(^)(void))showBlock play:(void(^)(void))playBlock {
    HXNoNetworkView *view = [[[NSBundle mainBundle] loadNibNamed:@"HXNoNetworkView" owner:self options:nil] firstObject];
    [view showOnViewController:viewController show:showBlock play:playBlock];
    return view;
}

+ (void)hidden {
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
    NSArray *subviews = mainWindow.subviews;
    for (UIView *view in subviews) {
        if ([view isKindOfClass:[HXNoNetworkView class]]) {
            [view removeFromSuperview];
            break;
        }
    }
}

- (void)showOnViewController:(UIViewController *)viewController show:(void(^)(void))showBlock play:(void(^)(void))playBlock {
    [viewController.navigationController popToRootViewControllerAnimated:NO];
    _showBlock = showBlock;
    _playBlock = playBlock;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
    self.frame = mainWindow.frame;
    [mainWindow addSubview:self];
}

- (void)hidden {
    [self removeFromSuperview];
}

@end
