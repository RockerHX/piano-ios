//
//  UIView+HXIBnspectable.h
//
//  Created by Andy Shaw on 15/6/16.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HXIBnspectable)

// Basic
@property (assign, nonatomic) IBInspectable   CGFloat  cornerRadius;
@property (assign, nonatomic) IBInspectable  NSString *hexRGBColor;


// Border
@property (assign, nonatomic) IBInspectable   CGFloat  borderWidth;
@property (strong, nonatomic) IBInspectable   UIColor *borderColor;
@property (strong, nonatomic) IBInspectable  NSString *borderHexRGBColor;


//// Shadow
@property (assign, nonatomic) IBInspectable   CGSize  shadowOffset;
@property (assign, nonatomic) IBInspectable  CGFloat  shadowOpacity;
@property (assign, nonatomic) IBInspectable  CGFloat  shadowRadius;
@property (strong, nonatomic) IBInspectable  UIColor *shadowColor;
@property (strong, nonatomic) IBInspectable NSString *shadowHexRGBColor;

@end
