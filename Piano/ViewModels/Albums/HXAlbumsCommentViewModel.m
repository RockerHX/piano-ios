//
//  HXAlbumsCommentViewModel.m
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsCommentViewModel.h"
#import "MiaAPIHelper.h"


@implementation HXAlbumsCommentViewModel

#pragma mark - Initialize Methods
- (instancetype)initWithAlbumID:(NSString *)albumID {
    self = [super init];
    if (self) {
        _albumID = albumID;
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    [self sendCommandConfigure];
}

- (void)sendCommandConfigure {
    @weakify(self)
    _sendCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self sendCommentRequestWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

#pragma mark - Private Methods
- (void)sendCommentRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper postAlbumComment:_albumID content:_content commentID:nil completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [subscriber sendNext:@"评论成功"];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

@end
