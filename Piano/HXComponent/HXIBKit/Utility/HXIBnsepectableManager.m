//
//  HXIBnsepectableManager.m
//
//  Created by Andy Shaw on 15/6/16.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "HXIBnsepectableManager.h"

@implementation HXIBnsepectableManager

+ (UIColor *)colorWithRGBHexString:(NSString *)hex {
    NSScanner *scanner = [NSScanner scannerWithString:hex];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) {
        return nil;
    }
    return [HXIBnsepectableManager colorWithRGBHex:hexNum];
}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:(r / 255.0f)
                           green:(g / 255.0f)
                            blue:(b / 255.0f)
                           alpha:1.0f];
}

@end
