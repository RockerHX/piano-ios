//
//  HXDiscoveryLiveBar.m
//  Piano
//
//  Created by miaios on 16/4/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryLiveBar.h"
#import "UIView+Frame.h"


@implementation HXDiscoveryLiveBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger radius = self.height / 2;
    CGPoint rightTopPoint = CGPointMake(self.boundsRight, self.boundsTop);
    CGPoint letTopPoint = CGPointMake(self.boundsLeft, self.boundsTop);
    CGPoint leftBottomPoint = CGPointMake(self.boundsLeft, self.boundsBottom);
    CGPoint rightBottomPoint = CGPointMake(self.boundsRight, self.boundsBottom);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, rightTopPoint.x, rightTopPoint.y);
    CGPathAddArcToPoint(path, NULL, letTopPoint.x, letTopPoint.y, leftBottomPoint.x, leftBottomPoint.y, radius);
    CGPathAddArcToPoint(path, NULL, leftBottomPoint.x, leftBottomPoint.y, rightBottomPoint.x, rightBottomPoint.y, radius);
    CGPathAddLineToPoint(path, NULL, rightBottomPoint.x, rightBottomPoint.y);
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    CGPathRelease(path);
    
    self.layer.mask = maskLayer;
}

@end
