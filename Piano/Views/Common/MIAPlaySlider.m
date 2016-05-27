//
//  MIAPlaySlider.m
//  Piano
//
//  Created by 刘维 on 16/5/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPlaySlider.h"

static CGFloat const kSliderProgressHeight = 10.;

@implementation MIAPlaySlider

- (CGRect)trackRectForBounds:(CGRect)bounds{
    
    bounds = [super trackRectForBounds:bounds];// 必须通过调用父类的trackRectForBounds获取一个bounds值，否则Autolayout会失效，UISlider的位置会跑偏。
    return CGRectMake(bounds.origin.x, bounds.origin.y-kSliderProgressHeight/2., bounds.size.width, kSliderProgressHeight);// 这里面的h即为你想要设置的高度。
}

//- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value
//{
//    bounds = [super thumbRectForBounds:bounds trackRect:rect value:value];// 这次如果不调用的父类的方法Autolayout倒是不会有问题，但是滑块根本就不动~
//    return CGRectMake(bounds.origin.x, bounds.origin.y+kSliderThumbHeight/2., kSliderThumbWidth, kSliderThumbHeight);// w和h是滑块可触摸范围的大小，跟通过图片改变的滑块大小应当一致。
//}

- (void)setSliderThumbHeight:(CGFloat)height color:(UIColor *)color{

    [self setThumbImage:[self getImageWithColor:color size:CGSizeMake(height, height) cornerRadius:height/2.] forState:UIControlStateNormal];
}

- (UIImage *)getImageWithColor:(UIColor *)color size:(CGSize )size cornerRadius:(CGFloat )radius{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setBackgroundColor:color];
    [[imageView layer] setCornerRadius:radius];
    [[imageView layer] setMasksToBounds:YES];
    [[imageView layer] setBorderWidth:2.];
    [[imageView layer] setBorderColor:[UIColor clearColor].CGColor];
    
    UIGraphicsBeginImageContext(CGSizeMake(imageView.frame.size.width, imageView.frame.size.height));
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
