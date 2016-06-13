//
//  MIASettingCell.h
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseTableViewCell.h"

@interface MIASettingCell : MIABaseTableViewCell

/**
 *  设置cell的标题跟内容.
 *
 *  @param title   标题.
 *  @param content 内容.
 */
- (void)setSettingCellTitle:(NSString *)title contnet:(NSString *)content;

/**
 *  设置右边的Accessory图标.
 *
 *  @param image Accessory图片.
 */
- (void)setCellAccessoryImage:(UIImage *)image;

/**
 *  设置cell标题的attributed Text.
 *
 *  @param attributedTitle NSAttributedString.
 */
- (void)setCellTitleAttributedText:(NSAttributedString *)attributedTitle;

@end
