//
//  HXSectorSlider.h
//  CircularSliderDemo
//
//  Created by miaios on 16/4/29.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXSectorSlider : UIControl

@property (nonatomic, assign)        CGFloat  arcLineWidth;
@property (nonatomic, assign)        CGFloat  sliderRadius;
@property (nonatomic, assign) NSTimeInterval  animationDuration;

@property (nonatomic, strong) UIColor *arcColor;
@property (nonatomic, strong) UIColor *sliderColor;

@end
