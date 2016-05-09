//
//  MIABaseCellView.h
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOBaseSDK.h"

@interface MIABaseShowView : UIView

@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *showTitleLabel;
@property (nonatomic, strong) UILabel *showTipLabel;

/**
 *  需要在该方法里面自己去添加布局
 */
- (void)updateViewLayout;

/**
 *  设置该视图显示需要的数据
 *
 *  @param data 显示需要的数据模型
 */
- (void)setShowData:(id)data;

@end
