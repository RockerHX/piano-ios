//
//  UILabel+JOExtend.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UILabel+JOExtend.h"

@implementation UILabel(Extend)

- (void)setJOFont:(JOFont *)font{

    [self setFont:font->font];
    [self setTextColor:font->color];
}

@end
