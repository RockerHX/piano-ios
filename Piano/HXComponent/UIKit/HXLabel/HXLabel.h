//
//  HXLabel.h
//  Mia
//
//  Created by miaios on 16/1/4.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXLabelVerticalAlignment) {
    HXLabelVerticalAlignmentTop,
    HXLabelVerticalAlignmentMiddle,
    HXLabelVerticalAlignmentBottom,
};

@interface HXLabel : UILabel

@property (nonatomic, assign) HXLabelVerticalAlignment  verticalAlignment;

@end
