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

#pragma mark - Private Methods
- (void)fetchCommentRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getReplyCommentWithRoomID:_model.roomID latitude:0 longitude:0 time:_timeNode completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            _timeNode = [data[@"time"] integerValue];
            [self addComment:data[@"comments"]];
            
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)addComment:(NSDictionary *)datas {
    NSMutableArray *comments = @[].mutableCopy;
    for (NSDictionary *data in datas) {
        HXCommentModel *model = [HXCommentModel mj_objectWithKeyValues:data];
        [comments addObject:model];
    }
    
    self.comments = [comments copy];
}

@end
