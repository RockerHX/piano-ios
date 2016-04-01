//
//  MIALabel.m
//  mia
//
//  Created by mia on 14-8-4.
//  Copyright (c) 2014年 Mia Music. All rights reserved.
//

#import "MIALabel.h"

@implementation MIALabel

/**
 *  自定义初始化UILabel
 *
 *  @param frame         大小
 *  @param text          文案
 *  @param font          字体
 *  @param textColor     文案颜色
 *  @param textAlignment 文案偏移位置
 *  @param numberLines   显示的行数
 *
 */
- (id)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        self.text = text == nil ? @"" : text;
        self.textColor = textColor == nil ? [UIColor blackColor] : textColor;
        self.font = font;
        self.textAlignment = textAlignment;
        self.numberOfLines = numberLines < 0 ? 0 : numberLines;
        if(self.numberOfLines > 0){
            self.lineBreakMode = NSLineBreakByTruncatingTail;
        }else{
            self.lineBreakMode = NSLineBreakByWordWrapping;
        }
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击开始");
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"点击结束");
    if(self.delegate){
        [self.delegate label:self touchesWtihTag:self.tag];
    }
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
