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


static NSUInteger WatcherMAX = 20;


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
    _watchers = @[];
    _comments = @[];
    
    [self signalLink];
    [self notificationConfigure];
    [self enterRoomCommandConfigure];
    [self leaveRoomCommandConfigure];
    [self checkAttentionStateCommandConfigure];
    [self takeAttentionCommandConfigure];
}

- (void)signalLink {
    _enterSignal = RACObserve(self, watchers);
    _exitSignal = [[NSNotificationCenter defaultCenter] rac_addObserverForName:WebSocketMgrNotificationPushRoomClose object:nil];
    _commentSignal = RACObserve(self, comments);
}

- (void)notificationConfigure {
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WebSocketMgrNotificationPushRoomEnter object:nil] subscribeNext:^(NSNotification *notification) {
        @strongify(self)
        NSDictionary *data = notification.userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
        [self addWatcher:data];
    }];
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WebSocketMgrNotificationPushRoomComment object:nil] subscribeNext:^(NSNotification *notification) {
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

#pragma mark - Public Methods
- (void)addWatcher:(NSDictionary *)data {
    NSMutableArray *watchers = _watchers.mutableCopy;
    if (watchers.count >= WatcherMAX) {
        [watchers removeLastObject];
    }
    
    HXWatcherModel *model = [HXWatcherModel mj_objectWithKeyValues:data];
    for (HXWatcherModel *watcher in _watchers) {
        if ([model.uID isEqualToString:watcher.uID]) {
            return;
        }
    }
    
    [watchers insertObject:model atIndex:0];
    self.watchers = [watchers copy];
}

- (void)addComment:(NSDictionary *)data {
    NSMutableArray *comments = _comments.mutableCopy;
    HXCommentModel *model = [HXCommentModel mj_objectWithKeyValues:data];
    [comments addObject:model];
    
    self.comments = [comments copy];
}

#pragma mark - Private Methods
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
    
    NSArray *onlineList = data[@"online"];
    for (NSDictionary *watcher in onlineList) {
        [self addWatcher:watcher];
    }
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
    [MiaAPIHelper followWithUID:_model.uID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
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
