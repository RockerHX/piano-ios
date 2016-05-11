//
//  UIView+JOExtend.h
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(Extend)

/**
 创建一个自动使用autolayout功能的对象.
 
 @return - 带有autolayout的对象.
 */
+ (instancetype)newAutoLayoutView;

/**
 @see 跟+ (instancetype)newAutoLayoutView功能一样.
 */
- (instancetype)initForAutoLayout;

@end
