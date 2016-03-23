//
//  HXIBLabel.h
//  TipTop-User
//
//  Created by ShiCang on 15/10/5.
//  Copyright © 2015年 Outsourcing. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface HXIBLabel : UILabel

// Border
@property (assign, nonatomic) IBInspectable BOOL topRightRadius;
@property (assign, nonatomic) IBInspectable BOOL topLeftRadius;
@property (assign, nonatomic) IBInspectable BOOL bottomRightRadius;
@property (assign, nonatomic) IBInspectable BOOL bottomLeftRadius;

@end
