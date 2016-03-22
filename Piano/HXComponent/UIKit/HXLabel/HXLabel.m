//
//  HXLabel.m
//  Mia
//
//  Created by miaios on 16/1/4.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLabel.h"

@implementation HXLabel

#pragma mark - Init Methods
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = HXLabelVerticalAlignmentMiddle;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.verticalAlignment = HXLabelVerticalAlignmentMiddle;
    }
    return self;
}

#pragma mark - Setter And Getter
- (void)setVerticalAlignment:(HXLabelVerticalAlignment)verticalAlignment {
    _verticalAlignment = verticalAlignment;
    [self setNeedsDisplay];
}

#pragma mark - Draw Methods
- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (_verticalAlignment) {
        case HXLabelVerticalAlignmentTop: {
            textRect.origin.y = bounds.origin.y;
            break;
        }
        case HXLabelVerticalAlignmentBottom: {
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        }
        case HXLabelVerticalAlignmentMiddle:
            // Fall through.
        default: {
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
            break;
        }
    }
    return textRect;
}

- (void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

@end
