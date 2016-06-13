//
//  MIASettingCellView.h
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIASettingCellView : UIView

/**
 *  设置相关的数据.
 *
 *  @param title   标题.
 *  @param content 内容.
 */
- (void)setTitle:(NSString *)title content:(NSString *)content;

/**
 *  设置图片.
 *
 *  @param image 图片.
 */
- (void)setAccessoryImage:(UIImage *)image;

/**
 *  设置标题的AttributedText
 *
 *  @param attributedTitle 标题的AttributedText
 */
- (void)setTitleAttributedText:(NSAttributedString *)attributedTitle;

@end
