//
//  UIColor+JOExtend.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 16/2/4.
//  Copyright © 2016年 刘维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JOMacro.h"

/*
 posix标准，一般整形对应的*_t类型为：(u开头为无符号的)
 1字节     uint8_t    int8_t
 2字节     uint16_t   int16_t
 4字节     uint32_t   int32_t
 8字节     uint64_t   int64_t
 */


/*
 struct JORGBColor {
    CGFloat r; //0 - 1.0
    CGFloat g; //0 - 1.0
    CGFloat b; //0 - 1.0
    CGFloat a; //0 - 1.0
 };
 typedef struct JORGBColor JORGBColor;
 */

/**
 *  RGB的表示的结构体JORGBColor
 */
#ifndef JORGB
#define JORGB struct JORGBColor
JORGB
{
    CGFloat r; //0 - 1.0
    CGFloat g; //0 - 1.0
    CGFloat b; //0 - 1.0
    CGFloat a; //0 - 1.0
};
#endif

JO_STATIC_INLINE JORGB JORGBColorMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a){

    JORGB RGBColor;RGBColor.r = fabs(r);RGBColor.g = fabs(g);RGBColor.b = fabs(b);RGBColor.a = fabs(a); return RGBColor;
}


#define JORGBCreate(r,g,b,a) [UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:a]
#define JORGBSameCreate(r)   [UIColor colorWithRed:r/255.f green:r/255.f blue:r/255.f alpha:1.]

@interface UIColor(Extend)

/**
 *  随机生成一个颜色,默认透明度为1.
 *
 *  @return UIColor对象.
 */
JO_EXTERN UIColor *JORandomColor();

/**
 *  将RGBColor的结构体数据转换为UIColor的对象.
 *
 *  @param rgbColor JORGBColor的结构体.
 *
 *  @return 转换后的UIColor的对象.
 */
JO_EXTERN UIColor *JOConvertRGBColorToColor(JORGB rgbColor);

/**
 *  将RGB的颜色转换为UIColor的对象.
 *
 *  @param r     r
 *  @param g     g
 *  @param b     b
 *  @param alpha 透明度
 *
 *  @return 转换后的UIColor对象.
 */
JO_EXTERN UIColor *JOConvertRGBToColor(CGFloat r,CGFloat g,CGFloat b,CGFloat alpha);

/**
 *  将RGB的颜色转换为UIColor的对象.这个RGB中的三个值是一样的时候,默认的透明度为:1.
 *
 *  @param r r
 *
 *  @return 转换后的UIColor对象.
 */
JO_EXTERN UIColor *JOConvertSameRGBToColor(CGFloat r);

/**
 *  将十六进制的字符串格式的值转换为UIColor的对象.
 *
 *  @param hexString 十六进制的字符串:@"0x66ccff" @"0x66ccffff" @"#66ccff" @"#66ccffff" @"66ccff" @"66ccffff"
 *
 *  @return 转换后的UIColor对象.
 */
JO_EXTERN UIColor *JOConvertHexRGBStringToColor(NSString *hexString);

/**
 *  将十六进制的字符串格式的值转换为UIColor的对象.
 *
 *  @param hexString 十六进制的字符串::@"0x66ccff" @"0x66ccffff" @"#66ccff" @"#66ccffff" @"66ccff" @"66ccffff"
 *  @param alpha     颜色的透明度.
 *
 *  @return 转换后的UIColor对象
 */
JO_EXTERN UIColor *JOConvertHexRGBStringDefineAlphaToColor(NSString *hexString,CGFloat alpha);

/**
 *  将UIColor的对象转换为用十六进制字符串来表示.
 *
 *  @param color UIColor的对象.
 *
 *  @return 转换后的十六进制的字符串.
 */
JO_EXTERN NSString *JOConvertColorToRGBHexString(UIColor *color);

/**
 *  将UIColor的对象转换为用十六进制字符串来表示.
 *
 *  @param color UIColor的对象.
 *
 *  @return  转换后的十六进制的字符串.
 */
JO_EXTERN NSString *JOConvertColorToRGBAHexString(UIColor *color);

/**
 *  将UIColor的对象转换为用十六进制来表示.
 *
 *  @param color UIColor对象.
 *
 *  @return 转换后的十六进制:0x66ccff
 */
JO_EXTERN uint32_t JOConvertColorToRGBHex(UIColor *color)NS_AVAILABLE_IOS(5_0);

/**
 *  将UIColor的对象转换为用十六进制来表示.
 *
 *  @param color UIColor对象.
 *
 *  @return 转换后的十六进制:0x66ccffff
 */
JO_EXTERN uint32_t JOConvertColorToRGBAHex(UIColor *color)NS_AVAILABLE_IOS(5_0);

/**
 *  将UICloro对象转换为JORGBValue的结构体.
 *  可以使用该方法取一个颜色的r g b a的数值.
 *
 *  @param color UIColor对象.
 *
 *  @return 转换后的JORGBColor的结构体.
 */
JO_EXTERN JORGB JOConvertColorToRGBColor(UIColor *color)NS_AVAILABLE_IOS(5_0);

/**
 *  将十六进制表示颜色的字符串转换为JORGBColor的结构体.默认的透明度为1.
 *
 *  @param hex 十六进制的颜色值
 *
 *  @return 转换后的JORGBValue的结构体.
 */
JO_EXTERN JORGB JOConvertHexRGBStringToRGBColor(NSString *hexString);

/**
 *  将十六进制表示颜色的字符串转换为JORGBColor的结构体.
 *
 *  @param hex 十六进制的颜色值:@"0x66ccff"
 *  @param alpha 透明度.
 *
 *  @return 转换后的JORGBValue的结构体.
 */
JO_EXTERN JORGB JOConvertHexRGBStringDefineAlphaToRGBColor(NSString *hexString,CGFloat alpha);

/**
 *  根据给定的UIColor对象获取该Color的色空间模型.
 *  更多信息查看:CGColorSpaceModel.
 *
 *  @param color UIColor对象.
 *
 *  @return 色空间模型的字符串.
 */
JO_EXTERN NSString *JOGetColorSpaceModelString(UIColor *color);

@end
