//
//  MIASettingContentViewController.h
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MIASettingContentViewModel.h"

/**
 *  修改保存成功的block.
 *
 *  @param contentType 内容的类型.
 *  @param content     保存的内容.
 */
typedef void(^SettingContentSaveBlock) (SettingContentType contentType, NSString *content);

@interface MIASettingContentViewController : UIViewController

/**
 *  初始化方法.
 *
 *  @param type 设置内容的类型.
 *
 *  @return 该对象.
 */
- (instancetype)initWithContentType:(SettingContentType)type;

/**
 *  设置内容.
 *
 *  @param content 内容.
 */
- (void)setSettingContent:(NSString *)content;

/**
 *  设置性别.
 *
 *  @param type GenderType
 */
- (void)setGenderType:(GenderType)type;

/**
 *  修改内容保存成功的block回调.
 *
 *  @param sendBlock SettingContentSaveBlock.
 */
- (void)settingContentSaveHandler:(SettingContentSaveBlock)sendBlock;

@end
