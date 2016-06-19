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
#import "HXUserSession.h"
#import "HXGiftManager.h"


@implementation HXRecordLiveViewModel {
    NSMutableArray *_watchersContainer;
    NSMutableArray *_commentsContainer;
}

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
    _comments = @[];
    _barrages = @[];
    
    [self signalLink];
    [self notificationConfigure];
    [self closeRoomCommandConfigure];
}

- (void)signalLink {
    _barragesSignal = RACObserve(self, barrages);
    _exitSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:WebSocketMgrNotificationPushRoomClose object:nil];
    _rewardSignal = [RACSubject subject];
    _giftSignal = [RACSubject subject];
}

- (void)notificationConfigure {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomEnter object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self updateOnlineCount:[data[@"onlineCnt"] integerValue]];
        [self addEnterBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomAttention object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addAttentionBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomShare object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addShareBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomGift object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addGiftBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomReward object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addRewardBarrage:data];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushRoomComment object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addComment:data];
    }];
    
    [[notificationCenter rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(NSNotification *notification) {
        [MiaAPIHelper livePostBackendWithRoomID:self.roomID completeBlock:nil timeoutBlock:nil];
    }];
    
    [[notificationCenter rac_addObserverForName:WebSocketMgrNotificationPushBackend object:nil] subscribeNext:^(NSNotification *notification) {
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addBackEndBarrage:data];
    }];
}

- (void)closeRoomCommandConfigure {
    @weakify(self)
    _closeRoomCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self closeRoomRequestWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

#pragma mark - Property
- (NSString *)roomID {
    return _model.roomID;
}

- (NSString *)anchorAvatar {
    return [HXUserSession session].user.avatarUrl;
}

- (NSString *)anchorNickName {
    return [HXUserSession session].user.nickName;
}

- (NSString *)onlineCount {
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
    
    HXGiftModel *gift = [[HXGiftManager manager] giftWithID:barrage.giftID];
    gift.nickName = barrage.nickName;
    gift.avatarUrl = barrage.avatarUrl;
    gift.count = barrage.giftCount;
    [_giftSignal sendNext:gift];
}

- (void)addRewardBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeReward;
    [self addBarrage:barrage];
    
    _model.album.rewardTotal = barrage.rewardTotal;
    [_rewardSignal sendNext:nil];
}

- (void)addBackEndBarrage:(NSDictionary *)data {
    HXBarrageModel *barrage = [HXBarrageModel mj_objectWithKeyValues:data];
    barrage.type = HXBarrageTypeBackEnd;
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
    if (barrages.count >= 100) {
        [barrages removeObjectsInRange:NSMakeRange(0, 50)];
    }
    self.barrages = [barrages copy];
}

- (void)updateOnlineCount:(NSInteger)count {
    _model.viewCount = count;
}

- (void)closeRoomRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper closeLiveWithRoomID:self.roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [subscriber sendCompleted];
        } else {
            [subscriber sendNext:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendNext:TimtOutPrompt];
    }];
}

@end
