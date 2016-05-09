//
//  JOUIManage.h
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JOUIManage : NSObject

#pragma mark - UILabel

/**
 *  创建一个UILabel
 *
 */
+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor;
+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor textFont:(UIFont *)font;
+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor
                             textFont:(UIFont *)font
                          numberLines:(NSInteger)numberLines;
+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor
                             textFont:(UIFont *)font
                        textAlignment:(NSTextAlignment)alignment
                        lineBreakMode:(NSLineBreakMode)lineBreakMode;
+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor
                             textFont:(UIFont *)font
                        textAlignment:(NSTextAlignment)alignment
                        lineBreakMode:(NSLineBreakMode)lineBreakMode
                          numberLines:(NSInteger)numberLines
                      backgroundColor:(UIColor *)groundColor;




@end
