//
//  UIViewController+HXClass.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import "HXStoryBoardManager.h"
#import "MBProgressHUD.h"
#import "UIViewController+LoginAction.h"

@interface UIViewController (HXClass)

+ (NSString *)segueIdentifier;
+ (NSString *)navigationControllerIdentifier;
+ (UINavigationController *)navigationControllerInstance;
+ (HXStoryBoardName)storyBoardName;
+ (instancetype)instance;

- (void)showAlertWithMessage:(NSString *)message;
- (void)showAlertWithMessage:(NSString *)message handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;
- (void)showAlertWithMessage:(NSString *)message otherTitle:(NSString *)title handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;

- (void)showMessage:(NSString *)message;
- (void)showToastWithMessage:(NSString *)message;
- (void)showToastWithMessage:(NSString *)message completedHandler:(void (^)(void))block;

- (void)showHUD;
- (void)hiddenHUD;

- (void)showHUDWithView:(UIView *)view;
- (void)hiddenHUDWithView:(UIView *)view;

- (void)showBannerWithPrompt:(NSString *)prompt;

@end
