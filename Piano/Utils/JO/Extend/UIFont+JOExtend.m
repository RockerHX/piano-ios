//
//  UIFont+JOExtend.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIFont+JOExtend.h"

@implementation JOFont

@end

@implementation UIFont(Extend)

JOFont * JOFontMake(NSString *fontName,UIColor *fontColor,CGFloat fontSize){

    JOFont *Font = [JOFont new];
    Font -> name = fontName;
    Font -> color = fontColor;
    Font -> size = fontSize;
    Font -> font = [UIFont fontWithName:fontName size:fontSize];
    return Font;
}

@end
