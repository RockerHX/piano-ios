//
//  HXReplaySlider.m
//  Piano
//
//  Created by miaios on 16/4/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplaySlider.h"

@implementation HXReplaySlider

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [self setThumbImage:[UIImage imageNamed:@"RP-SliderThumbIcon"] forState:UIControlStateNormal];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Parent Methods
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return (CGRect){bounds.origin.x, 4.5f, bounds.size.width, 5.0f};
}

@end
