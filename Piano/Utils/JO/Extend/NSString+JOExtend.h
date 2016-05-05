//
//  NSString+JOExtend.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 16/2/16.
//  Copyright © 2016年 刘维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOMacro.h"

@interface NSString(Extend)

/**
 *  将某些特殊的为nil,NULL的字符串转换为@"".
 *  因为某些地方要是使用nil的字符串可能会引起crash.
 */
JO_EXTERN NSString *JOConvertStringToNormalString(NSString *string);

/**
 *  去掉字符串首尾的空格与回车键的字符.
 *
 */
JO_EXTERN NSString *JOTrimString(NSString *string);

/**
 *  仅仅去掉字符串尾部的空格跟回车键的字符.
 *
 */
JO_EXTERN NSString *JOTrimEndString(NSString *string);

/**
 *  仅仅去掉字符串头部的空格跟回车键的字符.
 *
 */
JO_EXTERN NSString *JOTrimStartString(NSString *string);

/**
 *  处理字符串中所有的空格.
 *
 */
JO_EXTERN NSString *JOTrimAllSpaceString(NSString *string);

/**
 *  是否全部为数字.整型.
 *
*/
JO_EXTERN BOOL JOStringIsInt(NSString *string);

/**
 *  是否为浮点型.
 *
 */
JO_EXTERN BOOL JOStringIsFloat(NSString *string);

/**
 *  将十六进制的字符串转换为十进制的整型.
 *
 */
JO_EXTERN NSUInteger JOConvertHexStringToInt(NSString *string);

/**
 *  将10进制的整型转换为十六进制的字符串.
 *
 */
JO_EXTERN NSString *JOConvertIntToHexString(long long int intValue);

/**
 *  是否为有效的电话号码.
 *  能检测130-139 140-149 150-159 170-170 180-189之间的号码段
 *
 */
JO_EXTERN BOOL JOStringIsValidPhoneNumber(NSString *string);

/**
 *  是否为有效的邮箱地址.
 *
 */
JO_EXTERN BOOL JOStringIsValidEmail(NSString *string);

/**
 *  是否是合法的密码.
 *  ps:合法长度为6 - 16位 内容为大小写的a-z和0-9的字符组成,不能包括特殊的字符.
 *
 */
JO_EXTERN BOOL JOStringIsValidPassword(NSString *string);

/**
 *  是否是合法的身份证号码.
 *
 */
JO_EXTERN BOOL JOStringIsValidIDCardNum(NSString *string);


#pragma mark - Attributed String

/**
 *  按给定的Font跟NSParagraphStyle来生成可变的Attributed String.
 *
 *  @param font  字体.
 *  @param style NSParagraphStyle
 *
 *  @return 可变的Attributed String.
 */
- (NSMutableAttributedString *)JOAttributedStringWithFont:(UIFont *)font paragraphStyle:(NSParagraphStyle *)style;

/**
 *  按给定的Font跟行间距生成对应的可变的Attributed String.
 *  默认排版是居左.需要自定义这些其他的相关属性可以使用:- JOAttributedStringWithFont:paragraphStyle:方法
 *
 *  @param font      字体.
 *  @param lineSpace 行间距大小.
 *
 *  @return 可变的Attributed String.
 */
- (NSMutableAttributedString *)JOAttributedStringWithFont:(UIFont *)font lineSpace:(CGFloat )lineSpace;

/**
 *  将字符串转换成指定条件的Attributed String.
 *  多半用于drawString的时候,控件相关的属性建议使用:
 *  -JOAttributedStringwithMarkString:markFont:markColor:.
 *
 *  @param normalColor 整体的一般颜色.
 *  @param normalFont  整体的字体.
 *  @param markString  需要标记的字符串.
 *  @param markFont    标记字符串的字体.
 *  @param markColor   标记字符串的颜色.
 *
 *  @return 按给定条件生成的可变的Attributed String.
 */
- (NSMutableAttributedString *)JOAttributedStringwithNormalColor:(UIColor *)normalColor
                                                      normalFont:(UIFont *)normalFont
                                                      markString:(NSString *)markString
                                                        markFont:(UIFont *)markFont
                                                       markColor:(UIColor *)markColor;

/**
 *  将字符串转换成指定条件的Attributed String.
 *  默认的颜色为你控件(UILable UITextView UITextField)里面指定的颜色.
 *
 *  @param markString 需要标记的字符串.
 *  @param markFont   标记字符串的字体.
 *  @param markColor  标记字符串的颜色.
 *
 *  @return 按给定条件生成的可变的Attributed String.
 */
- (NSMutableAttributedString *)JOAttributedStringwithMarkString:(NSString *)markString
                                                       markFont:(UIFont *)markFont
                                                      markColor:(UIColor *)markColor;

#pragma mark - Size Of String
/**
 *  字符串显示所占用的Size大小.
 *
 *  @param font  字体.
 *  @param size  所给的size大小.
 *  @param model NSLineBreakMode.
 *
 *  @return 占用的size大小.
 */
- (CGSize)JOSizeWithFont:(UIFont *)font size:(CGSize)size lineBreakMode:(NSLineBreakMode)model;
- (CGSize)JOSizeWithFont:(UIFont *)font size:(CGSize)size;  //默认的line break mode:NSLineBreakByWordWrapping.


/**
 *  字符串显示所占用的高度.
 *
 *  @param font  字体.
 *  @param width  所给的宽度.
 *  @param model NSLineBreakMode.
 *
 *  @return 占用的size大小.
 */
- (CGFloat)JOHeightWithFont:(UIFont *)font width:(CGFloat)width lineBreakMode:(NSLineBreakMode)model;

/**
 *  给定行间距的字符串所占用的Size的大小.
 *
 *  @param font      字体.
 *  @param size      所给的size大小.
 *  @param lineSpace 行间距.
 *  @param style     NSParagraphStyle.
 *
 *  @return 占用的size大小.
 */
- (CGSize)JOSizeWithFont:(UIFont *)font size:(CGSize)size lineSpace:(CGFloat)lineSpace paragraphStyle:(NSParagraphStyle *)style;
- (CGSize)JOSizeWithFont:(UIFont *)font size:(CGSize)size lineSpace:(CGFloat)lineSpace; //默认的Style的属性:居左,NSLineBreakByWordWrapping.

/**
 *  给定行间距的字符串所占用的高度的大小.
 *
 *  @param font      字体.
 *  @param width     所给的宽度大小.
 *  @param lineSpace 行间距.
 *  @param style     NSParagraphStyle.
 *
 *  @return 占用的高度的大小.
 */
- (CGFloat)JOHeightWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace paragraphStyle:(NSParagraphStyle *)style;
- (CGFloat)JOHeightWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace; //默认的Style的属性:居左,NSLineBreakByWordWrapping.

/**
 *  该字符串在一行中完整显示所需要占得宽度.
 *
 *  @param font 字体.
 *
 *  @return 宽度.
 */
- (CGFloat)JOWidthWithFont:(UIFont *)font;

/**
 *  该字符串在给定宽度中完全显示所需要占得高度.
 *
 *  @param font  字体.
 *  @param width 给定的宽度.
 *
 *  @return 高度.
 */
- (CGFloat)JOHeightWithFont:(UIFont *)font width:(CGFloat)width;

#pragma mark - Regular Expression

/**
 *  根部正则表达式是否有匹配的结果.
 *
 *  @param regexString 正则表达式.
 *  @param options     NSRegularExpressionOptions
 *
 *  @return YES:有 NO:无
 */
- (BOOL)JOMatchesStateWithRegex:(NSString *)regexString options:(NSRegularExpressionOptions)options;

/**
 *  根据正则表达式一个一个检索出所有的条件的字符串.
 *
 *  @param regexString 正则表达式.
 *  @param options     NSRegularExpressionOptions
 *  @param block       每一次检索出符合条件的字符串该block都会回调.
 *                     matchString:符合条件的字符串 matchRange:Range stop:是否停止检索 -> *stop = YES 则会停止该block
 */
- (void)JOEnumerateMatchesWithRegex:(NSString *)regexString
                            options:(NSRegularExpressionOptions)options
                         usingBlock:(void (^)(NSString *matchString, NSRange matchRange, BOOL *stop))block;

/**
 *  替换正则表达式匹配出来的字符串.
 *
 *  @param regex       正则表达式.
 *  @param options     NSRegularExpressionOptions
 *  @param replacement 需要替换成的字符串.
 *
 *  @return 替换后的整个字符串.
 */
- (NSString *)JOStringByReplacingWithRegex:(NSString *)regex
                                   options:(NSRegularExpressionOptions)options
                                withString:(NSString *)replacement;
//TODO: 将URL的字符串中的中文做转化
//TODO: HTML文件中某些字符的转化

@end
