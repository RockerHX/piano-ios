//
//  MIAIncomeViewModel.m
//  Piano
//
//  Created by 刘维 on 16/6/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAIncomeViewModel.h"
#import "MIAIncomeModel.h"
#import "JOBaseSDK.h"

NSString *const kIncomeCellTitleKey = @"kIncomeCellTitleKey";
NSString *const kIncomeCellContentKey = @"kIncomeCellContentKey";

@interface MIAIncomeViewModel()

@property (nonatomic, strong) MIAIncomeModel *incomeModel;

@end

@implementation MIAIncomeViewModel

- (void)initConfigure{
    
    NSMutableDictionary *todayIncome = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"今日收益",kIncomeCellTitleKey,@" ",kIncomeCellContentKey, nil];
    NSMutableDictionary *yestodayIncome = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"昨日收益",kIncomeCellTitleKey,@" ",kIncomeCellContentKey, nil];
    NSMutableDictionary *monthIncome = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"本月收益",kIncomeCellTitleKey,@" ",kIncomeCellContentKey, nil];
    NSMutableDictionary *totalIncome = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"累计收入",kIncomeCellTitleKey,@" ",kIncomeCellContentKey, nil];
    NSMutableDictionary *availableIncome = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"未提现收入",kIncomeCellTitleKey,@" ",kIncomeCellContentKey, nil];
    _cellArray = @[@[todayIncome,yestodayIncome,monthIncome],@[totalIncome,availableIncome]];
    
    [self fetchIncomeDataCommand];
}

- (void)fetchIncomeDataCommand{
    
    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self fetchIncomeRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data operation

- (void)fetchIncomeRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getIncomeWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
            
//            NSLog(@"我的收益:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
            [self parseIncomeModelWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        }else{
        
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseIncomeModelWithData:(NSDictionary *)dic{

    self.incomeModel = [MIAIncomeModel mj_objectWithKeyValues:dic];
    [self updateCellData];
}

- (void)updateCellData{

    if ([_cellArray count]) {
        [[[_cellArray objectAtIndex:0] objectAtIndex:0] setObject:_incomeModel.todayIncome forKey:kIncomeCellContentKey];
        [[[_cellArray objectAtIndex:0] objectAtIndex:1] setObject:_incomeModel.yestodayIncome forKey:kIncomeCellContentKey];
        [[[_cellArray objectAtIndex:0] objectAtIndex:2] setObject:_incomeModel.monthIncome forKey:kIncomeCellContentKey];
        [[[_cellArray objectAtIndex:1] objectAtIndex:0] setObject:_incomeModel.historyTotal forKey:kIncomeCellContentKey];
        [[[_cellArray objectAtIndex:1] objectAtIndex:1] setObject:_incomeModel.availableTotal forKey:kIncomeCellContentKey];
        
        _availableMoney = _incomeModel.availableTotal;
        
    }else{
        [JOFException exceptionWithName:@"MIAIncomeViewModel exception!" reason:@"_cellArray 不能为空"];
    }
    
}

@end
