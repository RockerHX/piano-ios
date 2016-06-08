//
//  UIFont+JOExtend.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOMacro.h"

//#ifndef JOFontx
//#define JOFontx struct JOFontStruct
//JOFontx
//{
//    
//     NSString __unsafe_unretained*name;
//     UIColor __unsafe_unretained*color;
//     UIFont  __unsafe_unretained*font;
//    CFStringRef *cname;
//    CGFontRef *cFont;
//    CGColorRef *ccolor;
//    CGFloat size;
//    
//};
//#endif
//
//JO_STATIC_INLINE JOFontx JOFontMake( NSString *fontName,UIColor *fontColor,CGFloat fontSize){
//    
//    JOFontx Font;
//    
//    Font.name =  CFBridgingRelease(CFBridgingRetain(fontName));//fontName;
//    Font.color = CFBridgingRelease(CFBridgingRetain(fontColor));//fontColor;
//    Font.size = fontSize;
//    Font.font = CFBridgingRelease(CFBridgingRetain([UIFont fontWithName:fontName size:fontSize]));
//    return Font;
//}

@interface JOFont : NSObject{
    
    @public
    NSString *name;
    UIColor *color;
    UIFont *font;
    CGFloat size;
}

@end

@interface UIFont(Extend)

JO_EXTERN JOFont * JOFontMake(NSString *fontName,UIColor *fontColor,CGFloat fontSize);

JO_EXTERN JOFont * JOFontsMake(UIFont *font, UIColor *fontColor);

@end
