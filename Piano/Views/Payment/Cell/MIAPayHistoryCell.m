//
//  MIAPayHistoryCell.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPayHistoryCell.h"
#import "MIAPayHistoryCellView.h"

@interface MIAPayHistoryCell()

@property (nonatomic, strong) MIAPayHistoryCellView *payHistoryCellView;

@end

@implementation MIAPayHistoryCell

- (void)setCellWidth:(CGFloat)width{
    
    
}

- (void)createpayHistoryView{
    
    if (!self.payHistoryCellView) {
        
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        self.payHistoryCellView = [MIAPayHistoryCellView newAutoLayoutView];
        [self.cellContentView addSubview:_payHistoryCellView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(kContentViewInsideLeftSpaceDistance, 0., -kContentViewInsideRightSpaceDistance, 0.) selfView:_payHistoryCellView superView:self.cellContentView];
    }
}

- (void)setCellData:(id)data{
    
    [self createpayHistoryView];
    [_payHistoryCellView setPayHistoryData:data];
}

@end
