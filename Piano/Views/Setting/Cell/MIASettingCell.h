//
//  MIASettingCell.h
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseTableViewCell.h"

@interface MIASettingCell : MIABaseTableViewCell

- (void)setSettingCellTitle:(NSString *)title contnet:(NSString *)content;

- (void)setCellAccessoryImage:(UIImage *)image;

@end
