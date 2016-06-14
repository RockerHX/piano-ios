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
    CGRect rect = CGRectMake(0.0f, 0.0f, self.width, self.height);
    CGSize radii = CGSizeMake(radius, radius);
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomRight;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = path.CGPath;
    
    self.layer.mask = maskLayer;
}

@end
