//
//  UIView+HXIBnspectable.m
//
//  Created by Andy Shaw on 15/6/16.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "UIView+HXIBnspectable.h"
#import "HXIBnsepectableManager.h"

@implementation UIView (HXIBnspectable)

// If need IBnspectable shadow, you should open the code of the shadow properties and drawRect method
//#pragma mark - Draw Methods
//- (void)drawRect:(CGRect)rect
//{
//    {
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        
//        CGContextSaveGState(context);
//        
//        // Create an image from the text.
//        CGImageRef image = CGBitmapContextCreateImage(context);
//        
//        // Clear the content.
//        CGContextClearRect(context, rect);
//        
//        // Set shadow attributes.
//        CGContextSetShadowWithColor(context, self.shadowOffset, 1, self.shadowColor.CGColor);
//        
//        // Draw the saved image, which throws off a shadow.
//        CGContextDrawImage(context, rect, image);
//        
//        // Clean up.
//        CGImageRelease(image);
//        
//        CGContextRestoreGState(context);
//    }
//    
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [image drawInRect:rect];
//}

#pragma mark - Basic
- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setHexRGBColor:(NSString *)hexRGBColor {
    self.backgroundColor = [HXIBnsepectableManager colorWithRGBHexString:hexRGBColor];
}

- (NSString *)hexRGBColor {
    return @"0xffffff";
}

#pragma mark - Border Setter And Getter
- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderHexRGBColor:(NSString *)borderHexRGBColor {
    self.layer.borderColor = [HXIBnsepectableManager colorWithRGBHexString:borderHexRGBColor].CGColor;
}

- (NSString *)borderHexRGBColor {
    return @"0xffffff";
}

#pragma mark - Shadow
- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    if (shadowOpacity > 1.0f) {
        shadowOpacity = 1.0f;
    } else if (shadowOpacity < 0.0f) {
        shadowOpacity = 0.0f;
    }
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor {
    return [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowHexRGBColor:(NSString *)shadowHexRGBColor {
    self.layer.shadowColor = [HXIBnsepectableManager colorWithRGBHexString:shadowHexRGBColor].CGColor;
}

- (NSString *)shadowHexRGBColor {
    return @"0xffffff";
}

@end
