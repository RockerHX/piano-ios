//
//  HXWatchLiveViewModel.m
//  Piano
//
//  Created by miaios on 16/3/29.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatchLiveViewModel.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"


@implementation HXWatchLiveViewModel {
    NSMutableArray *_watchersContainer;
    NSMutableArray *_commentsContainer;
}

#pragma mark - Initialize Methods
- (instancetype)initWithRoomID:(NSString *)roomID {
    self = [super init];
    if (self) {
        _roomID = roomID;
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _comments = @[];
    _barrages = @[];
    
    [self signalConfigure];
    [self notificationConfigure];
    [self enterRoomCommandConfigure];
    [self leaveRoomCommandConfigure];
    [self checkAttentionStateCommandConfigure];
    [self takeAttentionCommandConfigure];
}

- (void)signalConfigure {
    _barragesSignal = RACObserve(self, barrages);
    _exitSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:WebSocketMgrNotificationPushRoomClose object:nil];
    _rewardSignal = [RACSubject subject];
    _giftSignal = [RACSubject subject];
}

- (void)notificationConfigure {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    @weakify(self)
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomEnter object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self updateOnlineCount:[data[@"onlineCnt"] integerValue]];
        [self addEnterBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomAttention object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addAttentionBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomShare object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addShareBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomGift object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addGiftBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomReward object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addRewardBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomComment object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addComment:data];
    }];
}

- (void)enterRoomCommandConfigure {
    @weakify(self)
    _enterRoomCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self enterRoomRequestWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

- (void)leaveRoomCommandConfigure {
    @weakify(self)
    _leaveRoomCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self leaveRoomRequestWithSubscriber:subscriber];
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
    return _model.avatarUrl;
}

- (NSString *)anchorNickName {
    return _model.nickName;
}

- (NSString *)viewCount {
    return @(_model.viewCount).stringValue;
}

#pragma mark - Private Methods
- (void)addEnterBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeEnter;
    [self addBarrage:barrage];
}

- (void)addAttentionBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeAttention;
    [self addBarrage:barrage];
}

- (void)addShareBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeShare;
    [self addBarrage:barrage];
}

- (void)addGiftBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeGift;
    [self addBarrage:barrage];
    
    [_giftSignal sendNext:barrage];
}

- (void)addRewardBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeReward;
    [self addBarrage:barrage];
    
    _model.album.rewardTotal = barrage.rewardTotal;
    [_rewardSignal sendNext:barrage];
}

- (void)addComment:(NSDictionary *)data {
    NSMutableArray *comments = _comments.mutableCopy;
    HXBarrageModel *barrage = [HXBarrageModel new];
    HXCommentModel *comment = [HXCommentModel mj_objectWithKeyValues:data];
    barrage.comment = comment;
    
    [comments addObject:comment];
    self.comments = [comments copy];
    [self addBarrage:barrage];
}

- (void)addBarrage:(HXBarrageModel *)barrage {
    NSMutableArray *barrages = _barrages.mutableCopy;
    [barrages addObject:barrage];
    self.barrages = [barrages copy];
}

- (void)updateOnlineCount:(NSInteger)count {
    _model.viewCount = count;
}

- (void)enterRoomRequestWithSubscriber:(id<RACSubscriber>)subscriber {
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

- (void)leaveRoomRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper leaveRoom:_roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseData:(NSDictionary *)data {
    _model = [HXLiveModel mj_objectWithKeyValues:data];
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

- (void)followRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper followWithRoomID:_roomID uID:_model.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
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
    [MiaAPIHelper unfollowWithUID:_model.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
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

@end
