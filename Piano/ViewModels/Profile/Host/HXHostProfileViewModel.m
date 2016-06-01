//
//  HXHostProfileViewModel.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXHostProfileViewModel.h"
#import "MiaAPIHelper.h"
#import "HXUserSession.h"
#import "UIConstants.h"


static CGFloat BorderSpace = 15.0f;
static CGFloat AttentionBottomSpace = 45.0f;
static CGFloat AlbumBottomSpace = 40.0f;


@implementation HXHostProfileViewModel

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
    _normalHeight = 56.0f;
    
    _attentionItemSpace = 25.0f;
    _albumItemSpace = 17.0f;
    
    _attentionItemWidth = ((SCREEN_WIDTH - (BorderSpace * 2) - (_attentionItemSpace*3)) / 4);
    _albumItemWidth = ((SCREEN_WIDTH - (BorderSpace * 2) - (_albumItemSpace * 2)) / 3);
    
    _attetionItemHeight = _attentionItemWidth + AttentionBottomSpace;
    _albumItemHeight = _albumItemWidth + AlbumBottomSpace;
    
    [self setupRowTypes];
    [self fetchDataCommandConfigure];
}

- (void)setupRowTypes {
    _rowTypes = @[@(HXHostProfileRowTypeRecharge),
                  @(HXHostProfileRowTypePurchaseHistory)];
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
    [MiaAPIHelper getUserProfileWithUID:[HXUserSession session].uid completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
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
    if (_model.attentions.count) {
        [rowTypes addObject:@(HXHostProfileRowTypeAttentionPrompt)];
        [rowTypes addObject:@(HXHostProfileRowTypeAttentions)];
    }
    if (_model.albums.count) {
        [rowTypes addObject:@(HXHostProfileRowTypeRewardAlbumPrompt)];
        [rowTypes addObject:@(HXHostProfileRowTypeRewardAlbums)];
    }
    
    [self resizeHeight];
    
    _rowTypes = [rowTypes copy];
    _rows = _rowTypes.count;
}

- (void)resizeHeight {
    NSInteger attentionCount = _model.attentions.count;
    _attentionHeight = (_attetionItemHeight * ((attentionCount / 4) + (attentionCount % 4)));
    
    NSInteger albumCount = _model.albums.count;
    _rewardAlbumHeight =  (_albumItemHeight * ((albumCount / 3) + ((albumCount % 3) ? 1 : 0)));
}

@end
