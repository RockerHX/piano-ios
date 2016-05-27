//
//  HXGiftManager.h
//  Piano
//
//  Created by miaios on 16/5/27.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXGiftModel.h"


@interface HXGiftManager : NSObject

@property (nonatomic, strong, readonly) NSArray <HXGiftModel *>*giftList;

+ (instancetype)manager;

- (void)fetchGiftList:(void(^)(HXGiftManager *manager))completed failure:(void(^)(NSString *prompt))failure;

- (HXGiftModel *)giftWithID:(NSString *)giftID;

@end
