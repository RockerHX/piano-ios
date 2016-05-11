//
//  UIFont+JOExtend.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOMacro.h"

#ifndef JOFont
#define JOFont struct JOFontStruct
JOFont
{
    
    __unsafe_unretained NSString *name;
    __unsafe_unretained UIColor *color;
    __unsafe_unretained UIFont  *font;
    CGFloat size;
    
};
#endif

JO_STATIC_INLINE JOFont JOFontMake(NSString *fontName,UIColor *fontColor,CGFloat fontSize){
    
    JOFont Font;
    Font.name = fontName;
    Font.color = fontColor;
    Font.size = fontSize;
    Font.font = [UIFont fontWithName:fontName size:fontSize];
    return Font;
}

@interface UIFont(Extend)

@end
