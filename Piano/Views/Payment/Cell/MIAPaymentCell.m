//
//  MIAPaymentCell.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPaymentCell.h"
#import "MIAPaymentCellView.h"

static CGFloat const kPaymentCellTopSpaceDistance = 15.; //头部的间距大小
static CGFloat const kPaymentCellBottomSpaceDistance = 15.; //底部的间距大小


@interface MIAPaymentCell()

@property (nonatomic, strong) MIAPaymentCellView *paymentCellView;

@end

@implementation MIAPaymentCell

- (void)setCellWidth:(CGFloat)width{
    
    
}

- (void)createPaymentView{
    
    if (!self.paymentCellView) {
        
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        self.paymentCellView = [MIAPaymentCellView newAutoLayoutView];
        [self.cellContentView addSubview:_paymentCellView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(kPaymentCellTopSpaceDistance, 0., -kPaymentCellBottomSpaceDistance, 0.) selfView:_paymentCellView superView:self.cellContentView];
    }
}

- (void)setCellData:(id)data{
    
    [self createPaymentView];
    [_paymentCellView setPaymentData:data];
//    [_paymentCellView set:data];
    
}

@end
