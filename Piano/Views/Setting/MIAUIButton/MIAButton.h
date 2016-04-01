//
//  MIAButton.h
//  mia
//
//  Created by mia on 14-8-6.
//  Copyright (c) 2014年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIAButton : UIButton

/**
 *  初始化自定义按钮
 *
 *  @param frame    大小
 *  @param imageUrl 图片的请求路径
 *
 */
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl;

/**
 *  初始化自定义按钮
 *
 *  @param frame           大小
 *  @param backgroundImage 背景（正常状态）
 *
 */
- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage;

/**
 *  初始化自定义按钮
 *
 *  @param frame            大小
 *  @param imageUrl         图片的请求路径
 *  @param placeholderImage 默认图片
 *
 */
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage;

/**
 *  初始化自定义按钮
 *
 *  @param frame            大小
 *  @param titleString      文案（正常状态）
 *  @param titleColor       文案颜色（正常状态）
 *  @param font             字体（正常状态）
 *  @param logoImg          图标（正常状态）
 *  @param backgroundImage  背景（正常状态）
 *
 */
- (id)initWithFrame:(CGRect)frame titleString:(NSString *)titleString titleColor:(UIColor *)titleColor font:(UIFont *)font logoImg:(UIImage *)logoImg backgroundImage:(UIImage *)backgroundImage;

@end
