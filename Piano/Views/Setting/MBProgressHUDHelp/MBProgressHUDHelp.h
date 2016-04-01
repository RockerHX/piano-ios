//
//  MBProgressHUDHelp.h
//  mia
//
//  Created by linyehui on 14-9-17.
//  Copyright (c) 2014年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

//typedef void(^RemoveMBProgressHUDBlock)();

@interface MBProgressHUDHelp : NSObject

/**
 *  显示纯文本的对话框
 *
 *  @param text 文本内容
 */
+ (void)showHUDWithModeText:(NSString *)text;

+ (void)showHUDWithModeTextAndNoSleep:(NSString *)text;

/**
 *  显示一个带文字的Loading，需要手动隐藏掉
 *
 *  @param text
 *
 */
+ (MBProgressHUD *)showLoadingWithText:(NSString *)text;

@end
