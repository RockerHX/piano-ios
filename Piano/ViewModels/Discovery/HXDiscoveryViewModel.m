//
//  HXDiscoveryViewModel.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryViewModel.h"
#import "MiaAPIHelper.h"
#import "UIConstants.h"
#import "HXUserSession.h"


@implementation HXDiscoveryViewModel

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
    [self requestCommandConfigure];
}

- (void)requestCommandConfigure {
    @weakify(self)
    _fetchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            @strongify(self)
            [self fetchDiscoveryListWithSubscriber:subscriber];
            return nil;
        }];
        return signal;
    }];
}

#pragma mark - Private Methods
- (void)fetchDiscoveryListWithSubscriber:(id<RACSubscriber>)subscriber {
    [MiaAPIHelper getMusiciansWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseData:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            [subscriber sendCompleted];
        } else {
            NSLog(@"getRoomList failed");
            [subscriber sendNext:userInfo[MiaAPIKey_Values][MiaAPIKey_Error]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        NSLog(@"getRoomList timeout");
        [subscriber sendNext:TimtOutPrompt];
    }];
}

- (void)parseData:(NSDictionary *)datas {
    NSArray *liveList = datas[@"live"];
    NSArray *musicianList = datas[@"musician"];
    NSMutableArray *discoveryList = @[].mutableCopy;
    
    HXUserSession *userSession = [HXUserSession session];
    if ((userSession.state == HXUserStateLogin) && (userSession.role == HXUserRoleAnchor)) {
        HXDiscoveryModel *model = [HXDiscoveryModel new];
        model.type = HXDiscoveryModelTypeAnchor;
        model.coverUrl = userSession.user.coverUrl;
        model.videoUrl = userSession.user.videoUrl;
        [discoveryList addObject:model];
    }
    
    for (NSDictionary *data in liveList) {
        HXDiscoveryModel *model = [HXDiscoveryModel mj_objectWithKeyValues:data];
        model.type = HXDiscoveryModelTypeLive;
        if (model) {
            [discoveryList addObject:model];
        }
    }
    
    for (NSDictionary *data in musicianList) {
        HXDiscoveryModel *model = [HXDiscoveryModel mj_objectWithKeyValues:data];
        model.type = HXDiscoveryModelTypeProfile;
        if (model) {
            [discoveryList addObject:model];
        }
    }
    
    _discoveryList = discoveryList.copy;
}

@end
