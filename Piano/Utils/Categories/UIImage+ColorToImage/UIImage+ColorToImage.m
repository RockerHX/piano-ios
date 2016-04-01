//
//  UIImage+ColorToImage.m
//
//  Created by linyehui on 14-8-6.
//
//

#import "UIImage+ColorToImage.h"

@implementation UIImage (ColorToImage)

/**
 *  颜色转为Image
 *
 *  @param color 颜色值
 *
 */
+ (UIImage *)createImageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *colorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImg;
}

@end
