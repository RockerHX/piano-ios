//
//  MIASettingViewController.h
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  当数据发生修改的时候触发的block
 *
 */
typedef void(^SettingDataChangeBlock) ();

@interface MIASettingViewController : UIViewController

@property (nonatomic, strong) UIImage *maskImage;

/**
 *  数据发生改变时block的回调.
 *
 *  @param block SettingDataChangeBlock.
 */
- (void)settingDataChangeHandler:(SettingDataChangeBlock)block;

@end
