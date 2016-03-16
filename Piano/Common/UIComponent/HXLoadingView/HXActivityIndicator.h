//
//  HXActivityIndicator.h
//
//  Created by ShiCang on 15/6/17.
//  Copyright (c) 2015年 ShiCang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXActivityIndicator : UIView

@property (nonatomic, assign)    BOOL  hidesWhenStopped;
@property (nonatomic, strong) UIColor *color;

- (void)startAnimating;
- (void)stopAnimating;
- (BOOL)isAnimating;

@end
