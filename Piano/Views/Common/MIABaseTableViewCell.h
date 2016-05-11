//
//  MIABaseTableViewCell.h
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOBaseSDK.h"

UIKIT_EXTERN CGFloat const kContentViewLeftSpaceDistance; //cell中的contentView与左边的间距
UIKIT_EXTERN CGFloat const kContentViewRightSpaceDistance; //cell中的contentView与右边的间距
UIKIT_EXTERN CGFloat const kContentViewTopSpaceDistance; //cell中的contentView与上边的间距
UIKIT_EXTERN CGFloat const kContentViewBottomSpaceDistance; //cell中contentView与下边的间距

//cell中ContentView内部中上下左右的间隙大小
UIKIT_EXTERN CGFloat const kContentViewInsideLeftSpaceDistance;
UIKIT_EXTERN CGFloat const kContentViewInsideRightSpaceDistance;
UIKIT_EXTERN CGFloat const kContentViewInsideTopSpaceDistance;
UIKIT_EXTERN CGFloat const kContentViewInsideBottomSpaceDistance;

@interface MIABaseTableViewCell : UITableViewCell

@property (nonatomic, strong) UIView *cellContentView;

/**
 *  设置cell的宽度,用来布局的时候,有的时候需要知道这个宽度
 *
 *  @param width cell的宽度
 */
- (void)setCellWidth:(CGFloat )width;

/**
 *  该cell需要的数据
 *
 *  @param data cell显示需要的data
 */
- (void)setCellData:(id)data;

@end
