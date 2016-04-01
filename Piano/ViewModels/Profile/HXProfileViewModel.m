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
    return 115.0f;
}

- (CGFloat)videoHeight {
    return 115.0f;
}

- (CGFloat)replayHeight {
    return 115.0f;
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
