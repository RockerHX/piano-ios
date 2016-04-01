//
//  MIAButton.m
//  mia
//
//  Created by mia on 14-8-6.
//  Copyright (c) 2014年 Mia Music. All rights reserved.
//

#import "MIAButton.h"
#import "UIButton+WebCache.h"
#import "UIImage+ColorToImage.h"
#import "UIImage+Extrude.h"

@implementation MIAButton

/**
 *  初始化自定义按钮
 *
 *  @param frame    大小
 *  @param imageUrl 图片的请求路径
 *
 */
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl{
    self = [MIAButton buttonWithType:UIButtonTypeCustom];
    if(self){
        self.frame = frame;
        [self sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self setBackgroundImage:[UIImage imageWithCutImage:image moduleSize:frame.size] forState:UIControlStateNormal];
        }];
        [self sd_setBackgroundImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateHighlighted completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self setBackgroundImage:[UIImage imageWithCutImage:image moduleSize:frame.size] forState:UIControlStateHighlighted];
        }];
    }
    return self;
}

/**
 *  初始化自定义按钮
 *
 *  @param frame           大小
 *  @param backgroundImage 背景（正常状态）
 *
 */
- (id)initWithFrame:(CGRect)frame backgroundImage:(UIImage *)backgroundImage{
    return [self initWithFrame:frame titleString:nil titleColor:nil font:nil logoImg:nil backgroundImage:backgroundImage];
}

/**
 *  初始化自定义按钮
 *
 *  @param frame            大小
 *  @param imageUrl         图片的请求路径
 *  @param placeholderImage 默认图片
 *
 */
- (id)initWithFrame:(CGRect)frame imageUrl:(NSString *)imageUrl placeholderImage:(UIImage *)placeholderImage{
    self = [MIAButton buttonWithType:UIButtonTypeCustom];
    if(self){
        self.frame = frame;
        [self sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:placeholderImage];
    }
    return self;
}

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
- (id)initWithFrame:(CGRect)frame titleString:(NSString *)titleString titleColor:(UIColor *)titleColor font:(UIFont *)font logoImg:(UIImage *)logoImg backgroundImage:(UIImage *)backgroundImage{
    self = [MIAButton buttonWithType:UIButtonTypeCustom];
    if(self){
        self.frame = frame;
        [self setTitle:titleString forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = font;
        [self setImage:logoImg forState:UIControlStateNormal];
        [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
