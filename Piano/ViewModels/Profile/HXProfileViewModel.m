//
//  HXProfileViewModel.m
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileViewModel.h"
#import "MiaAPIHelper.h"


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
    return 176.0f;
}

- (CGFloat)livingHeight {
    return 56.0f;
}

- (CGFloat)albumHeight {
    return 115.0f;
}

- (CGFloat)vedioHeight {
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
    [MiaAPIHelper getProfileWithUID:_uid completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseAttentionData:userInfo[MiaAPIKey_Values]];
            [subscriber sendCompleted];
        } else {
            [subscriber sendError:[NSError errorWithDomain:userInfo[MiaAPIKey_Values][MiaAPIKey_Error] code:-1 userInfo:nil]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [subscriber sendError:[NSError errorWithDomain:TimtOutPrompt code:-1 userInfo:nil]];
    }];
}

- (void)parseAttentionData:(NSDictionary *)data {
    ;
}

@end
