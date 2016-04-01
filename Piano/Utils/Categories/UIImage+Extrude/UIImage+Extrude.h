//
//  UIImage+Extrude.h
//
//  Created by linyehui on 14-8-19.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Extrude)

/**
 *  图片缩放
 *
 *  @param image 原图
 *  @param max_len  最大边缩放后的长度，短边等比缩放
 */
+(UIImage*)scaleToSize:(UIImage *)image maxWidthOrHeight:(CGFloat)max_len;

/*
 *   获取拉伸处理后的图片
 *   image              -->需要拉伸的图片资源(原图显示)
 */
+(UIImage *)imageExtrude:(UIImage *)image;

/**
 *  自定义拉伸处理后的图片
 *
 *  @param image      原始图像
 *  @param edgeInsets 拉伸的起始位置
 *
 */
+(UIImage *)imageExtrude:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInsets;

/**
 *  收缩图片
 *
 *  @param image 原图
 *  @param size  目标大小
 */
+ (UIImage *)imageWithShrink:(UIImage *)image shrinkSize:(float)size;

/**
 *  收缩图片后进行裁剪
 *
 *  @param image 原图
 *  @param size  目标大小
 *
 */
+ (UIImage *)imageWithCutImage:(UIImage *)image moduleSize:(CGSize)size;

/**
 *  裁剪图片为正方形，新的图片从左上角截取
 *
 *  @param image 原图
 *
 */
+ (UIImage *)imageWithCutImageToSquare:(UIImage *)image;

/**
 *  获取当前屏幕视图的UIImage(相当屏幕截图)
 *
 *  @param view     当前视图
 *  @param frame    要截取的范围
 *
 */
+ (UIImage *)getImageFromView:(UIView *)view frame:(CGRect)frame;

/**
 *  截取部分图像
 *
 *  @param rect 裁剪的区域
 *
 */
-(UIImage *)getSubImage:(CGRect)rect;
@end
