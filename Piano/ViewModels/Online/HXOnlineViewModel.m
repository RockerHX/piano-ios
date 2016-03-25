//
//  HXOnlineViewModel.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineViewModel.h"
#import "MiaAPIHelper.h"
#import "UIConstants.h"


@implementation HXOnlineViewModel

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
    _requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self fetchOnlineListWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

#pragma mark - Property
- (CGFloat)cellHeight {
    return SCREEN_WIDTH - 60.0f + 64.0f;
}

#pragma mark - Private Methods
- (void)fetchOnlineListWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getRoomListWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseDatas:userInfo[@"v"][@"data"]];
            [subscriber sendCompleted];
        } else {
            NSLog(@"getRoomList failed");
            [subscriber sendError:nil];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        NSLog(@"getRoomList timeout");
        [subscriber sendError:nil];
    }];
}

- (void)parseDatas:(NSArray *)datas {
    NSMutableArray *onlieList = @[].mutableCopy;
    for (NSDictionary *data in datas) {
        HXOnlineModel *model = [HXOnlineModel mj_objectWithKeyValues:data];
        [onlieList addObject:model];
    }
    _onlineList = onlieList.copy;
}

@end
