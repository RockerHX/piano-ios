//
//  MIAPaymentViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPaymentViewModel.h"
#import "MIARechargeModel.h"
#import "MIAMCoinModel.h"

CGFloat const kPaymentBarViewHeight = 150.;
CGFloat const kPaymentCellHeadViewHeight = 30.;
CGFloat const kPaymentCellHeight = 60.;

@interface MIAPaymentViewModel()

@end

@implementation MIAPaymentViewModel

- (void)initConfigure{

    _rechargeListArray = [NSMutableArray array];
    
    [self fetchRechargeListDataCommand];
    [self fetchMCoinBalanceDataCommand];
}

- (void)fetchRechargeListDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self fetchRechargeListRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)fetchMCoinBalanceDataCommand{

    @weakify(self);
    _fetchMCoinBalanceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self fetchMCoinBalanceRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data operation

- (void)fetchRechargeListRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getRechargeListWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
            [self parseRechargeListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
//            NSLog(@"充值的列表:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
            [subscriber sendCompleted];
        }else{
            
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)fetchMCoinBalanceRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getMCoinBalancesWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
//            [self parseRechargeListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
//            NSLog(@"M币余额:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
            [self parseMCoinBalanceWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        }else{
            
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseRechargeListWithData:(NSArray *)array{

    [_rechargeListArray removeAllObjects];
    for (int i = 0; i < [array count]; i++) {
        MIARechargeModel *rechargeModel = [MIARechargeModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        [_rechargeListArray addObject:rechargeModel];
    }
}

- (void)parseMCoinBalanceWithData:(NSDictionary *)dic{

    MIAMCoinModel *mCoinModel = [MIAMCoinModel mj_objectWithKeyValues:dic];
    _mCoin = [mCoinModel.mcoin copy];
}

@end
