//
//  UIView+Frame.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (Frame)

// shortcuts for positions
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat boundsX;
@property (nonatomic) CGFloat boundsY;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign)  CGSize size;

@end
