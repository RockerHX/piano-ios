//
//  HXRecordLiveViewModel.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXRecordLiveViewModel.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"


@implementation HXRecordLiveViewModel {
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
    _onlineCount = @"0";
    
    [self signalLink];
    [self notificationConfigure];
    [self leaveRoomCommandConfigure];
}

- (void)signalLink {
    _barragesSignal = RACObserve(self, barrages);
    _exitSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:WebSocketMgrNotificationPushRoomClose object:nil];
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
}

- (void)addRewardBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeReward;
    [self addBarrage:barrage];
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
    _onlineCount = @(count).stringValue;
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

@end
