//
//  HXProfileViewModel.m
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileViewModel.h"
#import "MiaAPIHelper.h"
#import "UIConstants.h"


static CGFloat LeftRightSpace = 30.0f;
static CGFloat AlbumBottomSpace = 50.0f;
static CGFloat VideoBottomSpace = 50.0f;
static CGFloat ReplayBottomSpace = 60.0f;


@implementation HXProfileViewModel {
    NSMutableArray *_rowTypes;
}

#pragma mark - Initialize Methods
- (instancetype)initWithUID:(NSString *)UID {
    self = [super init];
    if (self) {
        _uid = UID;
        [self initConfigure];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _albumItemSpace = 22.0f;
    _videoItemSpcae = 10.0f;
    _replayItemSpace = 10.0f;
    
    _albumItemWidth = (((SCREEN_WIDTH - LeftRightSpace) - _albumItemSpace*2) / 3);
    _videoItemWidth = (((SCREEN_WIDTH - LeftRightSpace) - _videoItemSpcae) / 2);
    _replayItemWidth = (((SCREEN_WIDTH - LeftRightSpace) - _replayItemSpace) / 2);
    
    _albumItemHeight = _albumItemWidth + AlbumBottomSpace;
    _videoItemHeight = (_videoItemWidth * (95.0f/168.0f)) + VideoBottomSpace;
    _replayItemHeight = _replayItemWidth + ReplayBottomSpace;
    
    
    [self setupRowTypes];
    [self fetchDataCommandConfigure];
}

- (void)setupRowTypes {
    _rowTypes = @[@(HXProfileRowTypeHeader)].mutableCopy;
}

- (void)fetchDataCommandConfigure {
    @weakify(self)
    _fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [self fetchProfileRequestWithSubscriber:subscriber];
            return nil;
        }];
    }];
}

#pragma mark - Property
- (CGFloat)headerHeight {
    return 240.0f;
}

- (CGFloat)livingHeight {
    return 130.0f;
}

- (CGFloat)albumHeight {
    return 40.0f + (_albumItemHeight * ((_model.albums.count / 3) + 1));
}

- (CGFloat)videoHeight {
    return 40.0f + (_videoItemHeight * ((_model.videos.count / 2) + 1));
}

- (CGFloat)replayHeight {
    return 40.0f + (_replayItemHeight * ((_model.replays.count / 2) + 1));
}

- (NSInteger)rows {
    return _rowTypes.count;
}

#pragma mark - Private Methods
- (void)fetchProfileRequestWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getMusicianProfileWithUID:_uid completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
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

- (void)parseAttentionData:(NSDictionary *)data {
    _model = [HXProfileModel mj_objectWithKeyValues:data];
    [self resetRowType];
}

- (void)resetRowType {
    NSMutableArray *rowTypes = [_rowTypes mutableCopy];
    if (_model.liveRoomID && _model.live) {
        [rowTypes addObject:@(HXProfileRowTypeLiving)];
    }
    if (_model.albums.count) {
        [rowTypes addObject:@(HXProfileRowTypeAlbumContainer)];
    }
    if (_model.videos.count) {
        [rowTypes addObject:@(HXProfileRowTypeVideoContainer)];
    }
    if (_model.replays.count) {
        [rowTypes addObject:@(HXProfileRowTypeReplayContainer)];
    }
    _rowTypes = [rowTypes copy];
}

@end
