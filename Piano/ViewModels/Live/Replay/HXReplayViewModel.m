//
//  HXReplayViewModel.m
//  Piano
//
//  Created by miaios on 16/4/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayViewModel.h"
#import "MiaAPIHelper.h"


@implementation HXReplayViewModel

#pragma mark - Init Methods
- (instancetype)initWithDiscoveryModel:(HXDiscoveryModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    [self fetchCommentCommandConfigure];
    [self signalLink];
}

- (void)fetchCommentCommandConfigure {
    @weakify(self)
    _fetchCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self fetchCommentRequestWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

- (void)signalLink {
    _reloadCommentSignal = RACObserve(self, comments);
}

#pragma mark - Private Methods
- (void)fetchCommentRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper enterRoom:_roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)addWatcher:(NSDictionary *)data {
//    NSMutableArray *watchers = _watchers.mutableCopy;
//    if (watchers.count >= WatcherMAX) {
//        [watchers removeLastObject];
//    }
//    
//    HXWatcherModel *model = [HXWatcherModel mj_objectWithKeyValues:data];
//    for (HXWatcherModel *watcher in _watchers) {
//        if ([model.uID isEqualToString:watcher.uID]) {
//            return;
//        }
//    }
//    
//    [watchers insertObject:model atIndex:0];
//    self.watchers = [watchers copy];
}

@end
