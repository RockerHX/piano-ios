//
//  UIViewController+HXClass.m
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "UIAlertView+BlocksKit.h"
#import "UIConstants.h"
#import "HXAlertBanner.h"

@implementation UIViewController (HXClass)

#pragma  mark - Class Methods
+ (NSString *)segueIdentifier { return @""; }

+ (NSString *)navigationControllerIdentifier { return @"";}

+ (UINavigationController *)navigationControllerInstance {
    @try {
        return [HXStoryBoardManager navigaitonControllerWithIdentifier:[self navigationControllerIdentifier] storyBoardName:[self storyBoardName]];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller Instance From Storybard Error:%@", exception.reason);
    }
    @finally {
    }
}

+ (HXStoryBoardName)storyBoardName { return 0;}

+ (instancetype)instance {
    @try {
        return [HXStoryBoardManager viewControllerWithClass:[self class] storyBoardName:[self storyBoardName]];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller Instance From Storybard Error:%@", exception.reason);
    }
    @finally {
    }
}

#pragma mark - Public Methods
- (void)showAlertWithMessage:(NSString *)message {
    [self showAlertWithMessage:message handler:nil];
}

- (void)showAlertWithMessage:(NSString *)message handler:(void (^)(UIAlertView *, NSInteger))block {
    [self showAlertWithMessage:message otherTitle:nil handler:block];
}

- (void)showAlertWithMessage:(NSString *)message otherTitle:(NSString *)title handler:(void (^)(UIAlertView *, NSInteger))block {
    [UIAlertView bk_showAlertViewWithTitle:@"温馨提示"
                                   message:message
                         cancelButtonTitle:@"确定"
                         otherButtonTitles:(title ? @[title] : nil)
                                   handler:block];
}


- (void)showMessage:(NSString *)message {
    if (message.length) {
        [self showToastWithMessage:message];
    }
}

- (void)showToastWithMessage:(NSString *)message {
    [self showToastWithMessage:message completedHandler:nil];
}

- (void)showToastWithMessage:(NSString *)message completedHandler:(void (^)(void))block {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.0f;
    hud.yOffset = SCREEN_HEIGHT/3;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:1.0f];
}

- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hiddenHUD {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)showHUDWithView:(UIView *)view{
    [MBProgressHUD showHUDAddedTo:view animated:YES];
}

- (void)hiddenHUDWithView:(UIView *)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

- (void)showBannerWithPrompt:(NSString *)prompt {
    if (prompt.length) {
        [HXAlertBanner showWithMessage:prompt tap:nil];
    }
}

@end
