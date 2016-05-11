//
//  HXSectorSlider.h
//  CircularSliderDemo
//
//  Created by miaios on 16/4/29.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXSectorSliderLevel) {
    HXSectorSliderLevelLow,
    HXSectorSliderLevelNormal,
    HXSectorSliderLevelMedium,
    HXSectorSliderLevelHigh,
    HXSectorSliderLevelVeryHigh,
};


@class HXSectorSlider;


@protocol HXSectorSliderDelegate <NSObject>

@optional
- (void)sectorSlider:(HXSectorSlider *)slider selectedLevel:(HXSectorSliderLevel)level;

@end


@interface HXSectorSlider : UIControl

@property (weak, nonatomic) IBOutlet id  <HXSectorSliderDelegate>delegate;

@property (nonatomic, assign)        CGFloat  arcLineWidth;
@property (nonatomic, assign)        CGFloat  sliderRadius;
@property (nonatomic, assign) NSTimeInterval  animationDuration;

@property (nonatomic, strong) UIColor *arcColor;
@property (nonatomic, strong) UIColor *sliderColor;

@end
