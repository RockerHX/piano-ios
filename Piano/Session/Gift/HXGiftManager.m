//
//  HXGiftManager.m
//  Piano
//
//  Created by miaios on 16/5/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXGiftManager.h"
#import "MiaAPIHelper.h"


@implementation HXGiftManager {
    NSDictionary *_giftMap;
}

#pragma mark - Singleton Methods
+ (instancetype)manager {
    static HXGiftManager *instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [HXGiftManager new];
    });

    return instance;
}

#pragma mark - Initialize Methods
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initConfigure];
        [self fetchGiftList:nil failure:nil];
    }
    return self;
}

#pragma mark - Configure Methods
- (void)initConfigure {
    _giftMap = @{};
}

#pragma mark - Public Methods
- (void)fetchGiftList:(void(^)(HXGiftManager *manager))completed failure:(void(^)(NSString *prompt))failure {
    [MiaAPIHelper getGiftListCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self parseGiftListWithLists:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            if (completed) {
                completed(self);
            }
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        if (failure) {
            failure(TimtOutPrompt);
        }
    }];
}

- (HXGiftModel *)giftWithID:(NSString *)giftID {
    return [_giftMap objectForKey:giftID];
}

#pragma mark - Private Methods
- (void)parseGiftListWithLists:(NSArray *)lists {
    NSMutableArray *giftList = @[].mutableCopy;
    NSMutableDictionary *giftMap = _giftMap.mutableCopy;
    for (NSDictionary *data in lists) {
        HXGiftModel *gift = [HXGiftModel mj_objectWithKeyValues:data];
        [giftList addObject:gift];
        [giftMap setObject:gift forKey:gift.ID];
    }
    _giftList = [giftList copy];
    _giftMap = [giftMap copy];
}

@end
