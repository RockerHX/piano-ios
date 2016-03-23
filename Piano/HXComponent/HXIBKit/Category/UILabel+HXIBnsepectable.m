//
//  UILabel+HXIBnsepectable.m
//
//  Created by Andy Shaw on 15/6/16.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "UILabel+HXIBnsepectable.h"
#import "HXIBnsepectableManager.h"

@implementation UILabel (HXIBnsepectable)

- (void)setTextHexColor:(NSString *)textHexColor {
    self.textColor = [HXIBnsepectableManager colorWithRGBHexString:textHexColor];
}

- (NSString *)textHexColor {
    return @"0xffffff";
}

@end
