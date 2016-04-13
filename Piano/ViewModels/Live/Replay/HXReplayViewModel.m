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
    _comments = @[];
    
    [self fetchCommentCommandConfigure];
    [self checkAttentionStateCommandConfigure];
    [self takeAttentionCommandConfigure];
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
- (void)updateTimeNode:(NSTimeInterval)node {
    _timeNode = node;
}

- (void)clearComments {
    _comments = @[];
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

- (void)addComment:(NSDictionary *)datas {
    NSMutableArray *comments = [_comments mutableCopy];
    for (NSDictionary *data in datas) {
        HXCommentModel *model = [HXCommentModel mj_objectWithKeyValues:data];
        [comments addObject:model];
    }
    
    self.comments = [comments copy];
}

@end
