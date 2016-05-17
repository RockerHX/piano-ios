//
//  MIAPaymentViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN CGFloat const kPaymentBarViewHeight; //Bar视图的高度
UIKIT_EXTERN CGFloat const kPaymentCellHeadViewHeight;//cell的头部的高度
UIKIT_EXTERN CGFloat const kPaymentCellHeight; //cell的高度

@interface MIAPaymentViewModel : MIAViewModel

@property (nonatomic, strong, readonly) NSMutableArray *rechargeListArray;

@property (nonatomic, strong) RACCommand *getMCoinBalanceCommand;

@end
