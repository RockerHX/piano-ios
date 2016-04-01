//
//  UIImage+ColorToImage.h
//
//  Created by linyehui on 14-8-6.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ColorToImage)

/**
 *  颜色转为Image
 *
 *  @param color 颜色值
 *
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;

@end
