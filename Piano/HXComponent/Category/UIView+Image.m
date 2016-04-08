//
//  UIView+Image.m
//  Piano
//
//  Created by miaios on 16/4/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIView+Image.h"


@implementation UIView (Image)

- (UIImage *)convertToImage {
    CGSize size = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
