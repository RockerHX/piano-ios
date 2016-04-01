//
//  MBProgressHUDHelp.m
//  mia
//
//  Created by linyehui on 14-9-17.
//  Copyright (c) 2014年 Mia Music. All rights reserved.
//

#import "MBProgressHUDHelp.h"

@implementation MBProgressHUDHelp

/**
 *  显示纯文本的对话框
 *
 *  @param text 文本内容
 */
+ (void)showHUDWithModeText:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:progressHUD];
    progressHUD.labelText = text;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD showAnimated:YES whileExecutingBlock:^{
        sleep(2);
    } completionBlock:^{
        [progressHUD removeFromSuperview];
    }];
}

+ (void)showHUDWithModeTextAndNoSleep:(NSString *)text{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *progressHUD = [[MBProgressHUD alloc] initWithView:window];
    [window addSubview:progressHUD];
    progressHUD.labelText = text;
    progressHUD.mode = MBProgressHUDModeText;
    [progressHUD show:YES];
}

+ (MBProgressHUD *)showLoadingWithText:(NSString *)text {
	UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
	MBProgressHUD *aProgressHUD = [[MBProgressHUD alloc] initWithView:window];
	[window addSubview:aProgressHUD];
	aProgressHUD.dimBackground = NO;
	aProgressHUD.labelText = text;
	[aProgressHUD show:YES];

	return aProgressHUD;
}

@end
