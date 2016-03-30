//
//  HXWatchLiveViewModel.h
//  Piano
//
//  Created by miaios on 16/3/29.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "HXLiveModel.h"


@interface HXWatchLiveViewModel : NSObject

@property (nonatomic, strong) HXLiveModel *model;

@property (nonatomic, strong, readonly)    NSString *roomID;

@property (nonatomic, strong, readonly) RACSignal *enterSignal;
@property (nonatomic, strong, readonly) RACSignal *exitSignal;
@property (nonatomic, strong, readonly) RACSignal *commentSignal;

@property (nonatomic, strong, readonly) RACCommand *enterRoomCommand;
@property (nonatomic, strong, readonly) RACCommand *leaveRoomCommand;

@property (nonatomic, strong, readonly) NSString *anchorAvatar;
@property (nonatomic, strong, readonly) NSString *anchorNickName;
@property (nonatomic, strong, readonly) NSString *viewCount;

@property (nonatomic, strong, readonly)  NSArray *watchers;
@property (nonatomic, strong, readonly)  NSArray *comments;


- (instancetype)initWithRoomID:(NSString *)roomID;
- (NSArray *)addWatcher:(NSDictionary *)data;
- (NSArray *)addComment:(NSDictionary *)data;

@end
