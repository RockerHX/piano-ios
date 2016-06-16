//
//  HXSectorSlider.m
//  CircularSliderDemo
//
//  Created by miaios on 16/4/29.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSectorSlider.h"


static CGFloat        ArcLineWidth      = 4.0f;
static CGFloat        SliderRadius      = 15.0f;
static CGFloat        OffsetY           = -20.0f;
static NSTimeInterval AnimationDuration = 0.2f;


@implementation HXSectorSlider {
    CAShapeLayer *_arcLayer;
    UIView       *_sliderView;
    
    CGPoint  _startPoint;
    CGPoint  _endPoint;
    CGPoint  _controlPoint;
    
    CGPoint  _point1;
    CGPoint  _point2;
    CGPoint  _point3;
    CGPoint  _point4;
    CGPoint  _point5;
}

#pragma mark - Initialize Methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height + OffsetY;
    _startPoint = CGPointMake(-10.0f, height);
    _endPoint = CGPointMake(width + 10.0f, height);
    _controlPoint = CGPointMake(width/2, height - width/5);
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:_startPoint];
    [path addQuadCurveToPoint:_endPoint controlPoint:_controlPoint];
    _arcLayer.path = path.CGPath;
    
    [self hanleSectionPoint];
}

#pragma mark - Configure Methods
- (void)setup {
    [self initConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _arcLineWidth = ArcLineWidth;
    _sliderRadius = SliderRadius;
    _animationDuration = AnimationDuration;
    
    _arcColor = [UIColor colorWithWhite:0.5f alpha:0.5f];
    _sliderColor = [UIColor whiteColor];
    
    self.clipsToBounds = YES;
}

- (void)viewConfigure {
    _arcLayer = [CAShapeLayer new];
    _arcLayer.lineWidth = _arcLineWidth;
    _arcLayer.fillColor = nil;
    _arcLayer.strokeColor = _arcColor.CGColor;
    [self.layer addSublayer:_arcLayer];
    
    _sliderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, _sliderRadius*2, _sliderRadius*2)];
    _sliderView.backgroundColor = _sliderColor;
    _sliderView.layer.cornerRadius = _sliderRadius;
//    _sliderView.layer.borderWidth = 2.;
//    _sliderView.layer.borderColor = [UIColor clearColor].CGColor;
    _sliderView.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    _sliderView.layer.shadowColor = [UIColor grayColor].CGColor;
    _sliderView.layer.shadowOpacity = 0.5f;
    [self addSubview:_sliderView];
    
    [_sliderView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
}

#pragma mark - Property
- (void)setArcLineWidth:(CGFloat)arcLineWidth {
    _arcLineWidth = arcLineWidth;
    _arcLayer.lineWidth = arcLineWidth;
}

- (void)setSliderRadius:(CGFloat)sliderRadius {
    _sliderRadius = sliderRadius;
    
    CGRect frame = _sliderView.frame;
    frame.size = CGSizeMake(sliderRadius * 2, sliderRadius * 2);
    _sliderView.frame = frame;
    _sliderView.layer.cornerRadius = sliderRadius;
}

- (void)setArcColor:(UIColor *)arcColor {
    _arcColor = arcColor;
    _arcLayer.strokeColor = arcColor.CGColor;
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    _sliderView.backgroundColor = sliderColor;
}

#pragma mark - Event Reponse
- (void)panGestureRecognizer:(UIPanGestureRecognizer* )panGesture {
    switch (panGesture.state) {
        case UIGestureRecognizerStateChanged: {
            [self moveHandleWithPoint:[panGesture locationInView:self]];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed: {
            [self moveEndWithPoint:[panGesture locationInView:self]];
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - Private Methods
- (void)hanleSectionPoint {
    NSInteger sectionWidth = self.bounds.size.width / 6;
    _point1 = [self pointOnArcWithX:sectionWidth];
    _point2 = [self pointOnArcWithX:sectionWidth*2];
    _point3 = [self pointOnArcWithX:sectionWidth*3];
    _point4 = [self pointOnArcWithX:sectionWidth*4];
    _point5 = [self pointOnArcWithX:sectionWidth*5];
    
    _sliderView.center = _point1;
    if (_delegate && [_delegate respondsToSelector:@selector(sectorSlider:selectedLevel:)]) {
        [_delegate sectorSlider:self selectedLevel:HXSectorSliderLevelLow];
    }
}

- (void)moveHandleWithPoint:(CGPoint)point {
    _sliderView.center = [self pointOnArcWithX:point.x];
}

- (void)moveEndWithPoint:(CGPoint)point {
    CGFloat midpoint1_2 = (_point1.x + _point2.x) / 2;
    CGFloat midpoint2_3 = (_point2.x + _point3.x) / 2;
    CGFloat midpoint3_4 = (_point3.x + _point4.x) / 2;
    CGFloat midpoint4_5 = (_point4.x + _point5.x) / 2;
    
    CGPoint endPoint;
    HXSectorSliderLevel level;
    if (point.x < midpoint1_2) {
        endPoint = _point1;
        level = HXSectorSliderLevelLow;
    } else if ((point.x >= midpoint1_2) && (point.x < midpoint2_3)) {
        endPoint = _point2;
        level = HXSectorSliderLevelNormal;
    } else if ((point.x >= midpoint2_3) && (point.x < midpoint3_4)) {
        endPoint = _point3;
        level = HXSectorSliderLevelMedium;
    } else if ((point.x >= midpoint3_4) && (point.x < midpoint4_5)) {
        endPoint = _point4;
        level = HXSectorSliderLevelHigh;
    } else {
        endPoint = _point5;
        level = HXSectorSliderLevelVeryHigh;
    }
    
    [UIView animateWithDuration:_animationDuration animations:^{
        _sliderView.center = endPoint;
    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(sectorSlider:selectedLevel:)]) {
            [_delegate sectorSlider:self selectedLevel:level];
        }
    }];
}

- (CGPoint)pointOnArcWithX:(CGFloat)x {
    CGFloat t = (x / (_endPoint.x - _startPoint.x));
    CGFloat pointY = (pow((1 - t), 2) * _startPoint.y) + ((2 * t) * (1 - t) * _controlPoint.y) + (pow(t, 2) * _endPoint.y);
    return CGPointMake(x, pointY);
}

@end
