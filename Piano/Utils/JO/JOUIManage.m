//
//  JOUIManage.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "JOUIManage.h"
#import "JOBaseSDK.h"

@implementation JOUIManage

+ (UILabel *)createLabelWithJOFont:(JOFont)joFont{

    return [JOUIManage createLabelWithTextColor:joFont.color textFont:joFont.font];
}

+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor{

    UILabel *label = [UILabel newAutoLayoutView];
    [label setTextColor:textColor];
    return label;
}

+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor textFont:(UIFont *)font{

    return [JOUIManage createLabelWithTextColor:textColor textFont:font numberLines:1];
}

+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor textFont:(UIFont *)font numberLines:(NSInteger)numberLines{

    return [JOUIManage createLabelWithTextColor:textColor
                                       textFont:font
                                  textAlignment:NSTextAlignmentLeft
                                  lineBreakMode:NSLineBreakByWordWrapping
                                    numberLines:numberLines
                                backgroundColor:[UIColor clearColor]];
}

+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor
                             textFont:(UIFont *)font
                        textAlignment:(NSTextAlignment)alignment
                        lineBreakMode:(NSLineBreakMode)lineBreakMode{

    return [JOUIManage createLabelWithTextColor:textColor
                                       textFont:font
                                  textAlignment:alignment
                                  lineBreakMode:lineBreakMode
                                    numberLines:1
                                backgroundColor:[UIColor clearColor]];
}

+ (UILabel *)createLabelWithTextColor:(UIColor *)textColor
                             textFont:(UIFont *)font
                        textAlignment:(NSTextAlignment)alignment
                        lineBreakMode:(NSLineBreakMode)lineBreakMode
                          numberLines:(NSInteger)numberLines
                      backgroundColor:(UIColor *)groundColor{

    UILabel *label = [UILabel newAutoLayoutView];
    [label setFont:font];
    [label setTextColor:textColor];
    [label setTextAlignment:alignment];
    [label setLineBreakMode:lineBreakMode];
    [label setNumberOfLines:numberLines];
    [label setBackgroundColor:groundColor];
    return label;
}

@end
