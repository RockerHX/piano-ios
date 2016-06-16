//
//  MIAIncomeModel.h
//  Piano
//
//  Created by 刘维 on 16/6/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MJExtension.h"

@interface MIAIncomeModel : NSObject

@property (nonatomic, copy) NSString *availableTotal; //可提现的金额 未提现的收入
@property (nonatomic, copy) NSString *historyTotal;//累计收益
@property (nonatomic, copy) NSString *monthIncome;//本月收益
@property (nonatomic, copy) NSString *todayIncome;//今日收益
@property (nonatomic, copy) NSString *yestodayIncome;//昨日收益

@end
