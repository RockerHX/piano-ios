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
    _barrages = @[];
    
    [self fetchBarrageCommandConfigure];
    [self checkAttentionStateCommandConfigure];
    [self viewReplayCommandConfigure];
    [self takeAttentionCommandConfigure];
}

- (void)fetchBarrageCommandConfigure {
    @weakify(self)
    _fetchBarrageCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self fetchBarrageRequestWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

- (void)checkAttentionStateCommandConfigure {
    @weakify(self)
    _checkAttentionStateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self checkAttentionStateRequestWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

- (void)viewReplayCommandConfigure {
    @weakify(self)
    _viewReplayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self viewReplayReuqest];
            return nil;
        }];
        return signal;
    }];
}

- (void)takeAttentionCommandConfigure {
    @weakify(self)
    _takeAttentionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            if (_anchorAttented) {
                [self unFollowRequestWithSubscriber:subscriber];
            } else {
                [self followRequestWithSubscriber:subscriber];
            }
            return nil;
        }];
        return signal;
    }];
}

#pragma mark - Property
- (NSString *)anchorAvatar {
    return _model.anchorAvatar;
}

- (NSString *)anchorNickName {
    return _model.nickName;
}

- (NSString *)viewCount {
    return _model.viewCount;
}

#pragma mark - Public Methods
- (void)updateTimeNode:(NSTimeInterval)node {
    _timeNode = node;
}

- (void)clearBarrages {
    _barrages = @[];
}

#pragma mark - Private Methods
- (void)fetchBarrageRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getReplyCommentWithRoomID:_model.roomID latitude:0 longitude:0 time:_timeNode completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            _timeNode = [data[@"time"] integerValue];
            [self addBarrages:data[@"comments"]];
            
            [subscriber sendCompleted];
        } else {
            [subscriber sendNext:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)checkAttentionStateRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getFollowStateWithUID:_model.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            _anchorAttented = [data[@"follow"] boolValue];
            [subscriber sendNext:@(_anchorAttented)];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)viewReplayReuqest {
    [MiaAPIHelper viewReplayWithRoomID:_model.roomID completeBlock:nil timeoutBlock:nil];
}

- (void)followRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper followWithRoomID:nil uID:_model.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            _anchorAttented = YES;
            [subscriber sendNext:@(_anchorAttented)];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)unFollowRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper unfollowWithUID:_model.uID roomID:nil completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            _anchorAttented = NO;
            [subscriber sendNext:@(_anchorAttented)];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)addBarrages:(NSDictionary *)datas {
    NSMutableArray *comments = [_barrages mutableCopy];
    for (NSDictionary *data in datas) {
        HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
        HXCommentModel *comment = [HXCommentModel mj_objectWithKeyValues:data];
        barrage.comment = comment;
        [comments addObject:barrage];
    }
    self.barrages = [comments copy];
}

@end
