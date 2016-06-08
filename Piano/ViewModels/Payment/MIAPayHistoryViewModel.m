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

CGFloat const kPayHistoryItemViewHeight = 56.;
CGFloat const kPayHistoryCellHeight = 81.;
CGFloat const kPayHistoryCellHeadHeight= 9.;
static NSString *const kRequestMaxLimitedCount = @"10";

@interface MIAPayHistoryViewModel(){

    BOOL sendGiftCompleteState;
    BOOL orderCompleteState;
    BOOL receiverGiftCompleteState;
}

@property (nonatomic, strong) RACCommand *fetchReceiveGiftListCommand;

@end

@implementation MIAPayHistoryViewModel

- (void)initConfigure{
    
    _sendGiftLsitArray = [NSMutableArray array];
    _orderListArray = [NSMutableArray array];
    _recevierGiftListArray = [NSMutableArray array];
    
    [self fetchRecevieGiftListDataCommand];
    [self fetchSendGiftListDataCommand];
    [self fetchOrderListDataCommand];
}

- (void)fetchRecevieGiftListDataCommand{

//    @weakify(self);
    self.fetchReceiveGiftListCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//    @strongify(self);
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            return nil;
        }];
    }];
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

#pragma mark - complete state

- (BOOL)sendGiftIsCompleteData{

    return sendGiftCompleteState;
}

- (BOOL)orderIsCompleteData{

    return orderCompleteState;
}

- (BOOL)receiverGiftIsCompleteData{

    return receiverGiftCompleteState;
}

#pragma mark - Data operation

- (void)fetchReceiveGiftListRequestWithSubscriber:(id<RACSubscriber>)subscriber{

    [MiaAPIHelper getReceiverListWithStart:[NSString stringWithFormat:@"%lu",(unsigned long)[_recevierGiftListArray count]]
                                     limit:kRequestMaxLimitedCount
                             completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                                 
                                 if (success) {
//                                     [self parseSendGiftListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                                     //            NSLog(@"收到的礼物列表:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                                     [subscriber sendCompleted];
                                 }else{
                                     
                                     [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                                 }
                             }
                              timeoutBlock:^(MiaRequestItem *requestItem) {
                                    [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                              }];
}

- (void)fetchSendGiftListRequestWithSubscriber:(id<RACSubscriber>)subscriber{
    
    NSString *startID = @"0";
    if ([_sendGiftLsitArray count]) {
     
        startID = [(MIASendGiftModel *)[_sendGiftLsitArray lastObject] id];
    }

    [MiaAPIHelper getSendGiftListWithStart:startID
                                     limit:kRequestMaxLimitedCount
                             completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
                                 if (success) {
                                     [self parseSendGiftListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
//                                                 NSLog(@"送出礼物的列表:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                                     [subscriber sendCompleted];
                                 }else{
                                     
                                     [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                                 }
                             }
                              timeoutBlock:^(MiaRequestItem *requestItem) {
                                  [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                              }];
}

- (void)fetchOrderListRequestWithSubscriber:(id<RACSubscriber>)subscriber{
    
    NSString *startID = @"0";
    if ([_orderListArray count]) {
        
        startID = [(MIAOrderModel *)[_orderListArray lastObject] id];
    }
    
    [MiaAPIHelper getOrderListWithStart:startID
                                  limit:kRequestMaxLimitedCount
                          completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                              if (success) {
                                  [self parseOrderListWithData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
//                                  NSLog(@"充值的列表:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Data]);
                                  [subscriber sendCompleted];
                              }else{
                                      
                                      [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
                                  }
                          }
                           timeoutBlock:^(MiaRequestItem *requestItem) {
        
                                    [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
                           }];
}

- (void)parseSendGiftListWithData:(NSArray *)array{

    if ([array count] == [kRequestMaxLimitedCount integerValue]) {

        sendGiftCompleteState = YES;
    }else{
        
        sendGiftCompleteState = NO;
    }
    
    for (int i = 0; i < [array count]; i++) {
        MIASendGiftModel *sendGiftModel = [MIASendGiftModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        [_sendGiftLsitArray addObject:sendGiftModel];
    }
}

- (void)parseOrderListWithData:(NSArray *)array{

    if ([array count] == [kRequestMaxLimitedCount integerValue]) {
        
        orderCompleteState = YES;
    }else{
        
        orderCompleteState = NO;
    }
    
    for (int i = 0; i < [array count]; i++) {
        MIAOrderModel *orderModel = [MIAOrderModel mj_objectWithKeyValues:[array objectAtIndex:i]];
        [_orderListArray addObject:orderModel];
    }
}

@end
