//
//  MIAPayHistoryViewModel.m
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAPayHistoryViewModel.h"
#import "MIASendGiftModel.h"
#import "MIAOrderModel.h"

CGFloat const kPayHistoryItemViewHeight = 50.;
CGFloat const kPayHistoryCellHeight = 70.;
CGFloat const kPayHistoryCellHeadHeight= 11.;

@interface MIAPayHistoryViewModel()

@end

@implementation MIAPayHistoryViewModel

- (void)initConfigure{

    _sendGiftLsitArray = [NSMutableArray array];
    _orderListArray = [NSMutableArray array];
    
    [self fetchSendGiftListDataCommand];
    [self fetchOrderListDataCommand];
}

- (void)fetchSendGiftListDataCommand{

    @weakify(self);
    self.fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           
            [self fetchSendGiftListRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)fetchOrderListDataCommand{

    @weakify(self);
    _fetchOrderListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [self fetchOrderListRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Data operation

- (void)fetchSendGiftListRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getSendGiftListWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
            [self parseSendGiftListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
//            NSLog(@"送出礼物的列表:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
            [subscriber sendCompleted];
        }else{
            
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)fetchOrderListRequestWithSubscriber:(id<RACSubscriber>)subscriber{
    
    [MiaAPIHelper getOrderListWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
            [self parseOrderListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
//            NSLog(@"充值的列表:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
            [subscriber sendCompleted];
        }else{
            
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseSendGiftListWithData:(NSArray *)array{

    [_sendGiftLsitArray removeAllObjects];
    for (int i = 0; i < [array count]; i++) {
        MIASendGiftModel *sendGiftModel = [MIASendGiftModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        [_sendGiftLsitArray addObject:sendGiftModel];
    }
}

- (void)parseOrderListWithData:(NSArray *)array{

    [_orderListArray removeAllObjects];
    for (int i = 0; i < [array count]; i++) {
        MIAOrderModel *orderModel = [MIAOrderModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        [_orderListArray addObject:orderModel];
    }
}

@end
