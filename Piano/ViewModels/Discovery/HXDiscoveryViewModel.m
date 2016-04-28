//
//  HXDiscoveryViewModel.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryViewModel.h"
#import "MiaAPIHelper.h"
#import "UIConstants.h"


@implementation HXDiscoveryViewModel

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    [self requestCommandConfigure];
}

- (void)requestCommandConfigure {
    @weakify(self)
    _fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self fetchDiscoveryListWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

#pragma mark - Private Methods
- (void)fetchDiscoveryListWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getMusiciansWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        } else {
            NSLog(@"getRoomList failed");
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        NSLog(@"getRoomList timeout");
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseData:(NSArray *)datas {
    NSMutableArray *discoveryList = @[].mutableCopy;
    for (NSDictionary *data in datas) {
        HXDiscoveryModel *model = [HXDiscoveryModel mj_objectWithKeyValues:data];
        [discoveryList addObject:model];
    }
    _discoveryList = discoveryList.copy;
}

@end
