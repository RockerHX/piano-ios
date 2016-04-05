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


@implementation HXAlbumsViewModel

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
    _rowTypes = @[@(HXAlbumsRowTypeControl)];
    
    [self fetchDataCommandConfigure];
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

#pragma mark - Property
- (CGFloat)controlHeight {
    return SCREEN_WIDTH - 10.0f - 15.0f + 61.0f;
}

- (CGFloat)songHeight {
    return 50.0f;
}

- (CGFloat)promptHeight {
    return 50.0f;
}

- (NSInteger)rows {
    return _rowTypes.count;
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

- (void)parseAttentionData:(NSDictionary *)data {
//    _model = [HXProfileModel mj_objectWithKeyValues:data];
    [self resetRowType];
}

- (void)resetRowType {
//    if (_model.attentions.count) {
//        NSMutableArray *rowTypes = [_rowTypes mutableCopy];
//        for (NSInteger index = 4; index < _rowTypes.count; index++) {
//            HXMeRowType rowType = [_rowTypes[index] integerValue];
//            if ((rowType == HXMeRowTypeAttentionPrompt) || (rowType == HXMeRowTypeAttentions)) {
//                return;
//            }
//        }
//        [rowTypes insertObject:@(HXMeRowTypeAttentionPrompt) atIndex:4];
//        [rowTypes insertObject:@(HXMeRowTypeAttentions) atIndex:5];
//        _rowTypes = [rowTypes copy];
//    }
}

@end
