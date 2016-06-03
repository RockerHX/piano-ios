//
//  HXDiscoveryCell.m
//  Piano
//
//  Created by miaios on 16/4/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryCell.h"
#import "UIView+Frame.h"


@implementation HXDiscoveryCell

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    self.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"D-LiveEntryBG"].CGImage);
    self.layer.contentsGravity = kCAGravityResizeAspectFill;
}

#pragma mark - Layout Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSInteger radius = self.width / 12;
    CGPoint leftBottomPoint = CGPointMake(self.boundsLeft, self.boundsBottom);
    CGPoint rightBottomPoint = CGPointMake(self.boundsRight, self.boundsBottom);
    CGPoint rightTopPoint = CGPointMake(self.boundsRight, self.boundsTop);
    CGPoint letTopPoint = CGPointMake(self.boundsLeft, self.boundsTop);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, leftBottomPoint.x, leftBottomPoint.y);
    CGPathAddArcToPoint(path, NULL, rightBottomPoint.x, rightBottomPoint.y, rightTopPoint.x, rightTopPoint.y, radius);
    CGPathAddArcToPoint(path, NULL, rightTopPoint.x, rightTopPoint.y, letTopPoint.x, letTopPoint.y, radius);
    CGPathAddArcToPoint(path, NULL, letTopPoint.x, rightTopPoint.y, leftBottomPoint.x, leftBottomPoint.y, radius);
    CGPathAddLineToPoint(path, NULL, leftBottomPoint.x, leftBottomPoint.y);
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path;
    CGPathRelease(path);
    
    self.layer.mask = maskLayer;
}

@end
