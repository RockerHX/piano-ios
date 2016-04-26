//
//  UIView+Frame.m
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

#pragma mark - Shortcuts for positions
- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)top {
    return self.y;
}

- (void)setTop:(CGFloat)top {
    self.y = top;
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    self.y = bottom - self.height;
}

- (CGFloat)left {
    return self.x;
}

- (void)setLeft:(CGFloat)left {
    self.x = left;
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    self.x = right - self.width;
}

- (CGFloat)boundsX {
    return CGRectGetMinX(self.bounds);
}

- (void)setBoundsX:(CGFloat)boundsX {
    CGRect bounds = self.bounds;
    bounds.origin.x = boundsX;
    self.bounds = bounds;
}

- (CGFloat)boundsY {
    return CGRectGetMinY(self.bounds);
}

- (void)setBoundsY:(CGFloat)boundsY {
    CGRect bounds = self.bounds;
    bounds.origin.y = boundsY;
    self.bounds = bounds;
}

- (CGFloat)boundsTop {
    return self.boundsY;
}

- (void)setBoundsTop:(CGFloat)boundsTop {
    self.boundsY = boundsTop;
}

- (CGFloat)boundsBottom {
    return CGRectGetMaxY(self.bounds);
}

- (void)setBoundsBottom:(CGFloat)boundsBottom {
    self.boundsY = boundsBottom - self.height;
}

- (CGFloat)boundsLeft {
    return self.boundsX;
}

- (void)setBoundsLeft:(CGFloat)boundsLeft {
    self.boundsX = boundsLeft;
}

- (CGFloat)boundsRight {
    return CGRectGetMaxX(self.bounds);
}

- (void)setBoundsRight:(CGFloat)boundsRight {
    self.boundsX = boundsRight - self.width;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

#pragma mark - Shortcuts for frame properties
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
