//
//  MIAIncomeViewModel.h
//  Piano
//
//  Created by 刘维 on 16/6/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN NSString *const kIncomeCellTitleKey;
UIKIT_EXTERN NSString *const kIncomeCellContentKey;

@interface MIAIncomeViewModel : MIAViewModel

@property (nonatomic, readonly) NSArray *cellArray;
//可提现的金额
@property (nonatomic, readonly) NSString *availableMoney;

@end
