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
    
    _headerHeight = 240.0f;
    _livingHeight = 130.0f;
    
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
    [self resizeHeight];
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
    _rows = rowTypes.count;
}

- (void)resizeHeight {
    NSInteger replayCount = _model.replays.count;
    _replayHeight = 40.0f + (_replayItemHeight * ((replayCount / 2) + (replayCount % 2)));
    
    NSInteger albumCount = _model.albums.count;
    _albumHeight = 40.0f + (_albumItemHeight * ((albumCount / 3) + ((albumCount % 3) ? 1 : 0)));
    
    NSInteger videoCount = _model.videos.count;
    _videoHeight = 40.0f + (_videoItemHeight * ((videoCount / 2) + (videoCount % 2)));
}

@end
