//
//  HXAlbumsViewModel.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsViewModel.h"
#import "UIConstants.h"
#import "MiaAPIHelper.h"


@implementation HXAlbumsViewModel {
    NSString *_lastCommentID;
    NSInteger _commentLimit;
}

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
    _songStartIndex = 1;
    
    _controlHeight = SCREEN_WIDTH - 10.0f - 15.0f + 61.0f;
    _songHeight = 50.0f;
    _promptHeight = 50.0f;
    
    _rowTypes = @[@(HXAlbumsRowTypeControl)];
    
    _lastCommentID = @"0";
    _commentLimit = 10;
    
    [self fetchDataCommandConfigure];
    [self reloadCommentCommandConfigure];
    [self moreCommentCommandConfigure];
}

- (void)fetchDataCommandConfigure {
    @weakify(self)
    _fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self fetchAlbumsDataRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)reloadCommentCommandConfigure {
    @weakify(self)
    _reloadCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            _lastCommentID = @"0";
            _comments = @[].mutableCopy;
            [self moreCommentRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

- (void)moreCommentCommandConfigure {
    @weakify(self)
    _moreCommentCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self moreCommentRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Private Methods
- (void)fetchAlbumsDataRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getAlbumWithID:_albumID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseAttentionData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)moreCommentRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getAlbumComment:_albumID lastCommentID:_lastCommentID limit:_commentLimit completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self addCommentsWithCommentList:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseAttentionData:(NSDictionary *)data {
    _model = [HXAlbumModel mj_objectWithKeyValues:data];
    
    NSArray *songList = data[@"song"];
    NSMutableArray *songs = [[NSMutableArray alloc] initWithCapacity:songList.count];
    for (NSDictionary *songData in songList) {
        HXSongModel *model = [HXSongModel mj_objectWithKeyValues:songData];
        [songs addObject:model];
    }
    _songs = [songs copy];
    
    NSArray *commentList = data[@"commentList"];
    NSMutableArray *comments = [[NSMutableArray alloc] initWithCapacity:commentList.count];
    for (NSDictionary *commentData in commentList) {
        HXCommentModel *model = [HXCommentModel mj_objectWithKeyValues:commentData];
        [comments addObject:model];
    }
    _comments = [comments copy];
    _lastCommentID = [_comments lastObject].ID;
    
    [self resetRowType];
}

- (void)resetRowType {
    NSMutableArray *rowTypes = [_rowTypes mutableCopy];
    if (_songs.count) {
        [_songs enumerateObjectsUsingBlock:^(HXSongModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [rowTypes addObject:@(HXAlbumsRowTypeSong)];
        }];
    }
    if (_comments.count) {
        [rowTypes addObject:@(HXAlbumsRowTypeCommentCount)];
        _commentStartIndex = rowTypes.count;
        [_comments enumerateObjectsUsingBlock:^(HXCommentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [rowTypes addObject:@(HXAlbumsRowTypeComment)];
        }];
    }
    _rowTypes = [rowTypes copy];
    _rows = rowTypes.count;
}

- (void)addCommentsWithCommentList:(NSArray *)commentList {
    NSMutableArray *comments = [_comments mutableCopy];
    for (NSDictionary *commentData in commentList) {
        HXCommentModel *model = [HXCommentModel mj_objectWithKeyValues:commentData];
        [comments addObject:model];
    }
    _comments = [comments copy];
    _lastCommentID = [_comments lastObject].ID;
    
    NSMutableArray *rowTypes = [_rowTypes mutableCopy];
    if (commentList.count) {
        [_rowTypes enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj integerValue] == HXAlbumsRowTypeComment) {
                [rowTypes removeObject:obj];
            }
        }];
        
        [_comments enumerateObjectsUsingBlock:^(HXCommentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [rowTypes addObject:@(HXAlbumsRowTypeComment)];
        }];
    }
    _rowTypes = [rowTypes copy];
    _rows = rowTypes.count;
}

@end
