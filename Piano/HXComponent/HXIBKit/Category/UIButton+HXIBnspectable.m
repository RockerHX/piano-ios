//
//  UIButton+HXIBnspectable.m
//
//  Created by Andy Shaw on 15/6/16.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "UIButton+HXIBnspectable.h"
#import "HXIBnsepectableManager.h"

@implementation UIButton (HXIBnspectable)

- (void)setTitleHexColor:(NSString *)titleHexColor {
    [self setTitleColor:[HXIBnsepectableManager colorWithRGBHexString:titleHexColor] forState:UIControlStateNormal];
}

- (NSString *)titleHexColor {
    return @"0xffffff";
}

@end
