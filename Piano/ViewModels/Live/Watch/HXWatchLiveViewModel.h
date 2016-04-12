//
//  HXWatchLiveViewModel.h
//  Piano
//
//  Created by miaios on 16/3/29.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "ReactiveCocoa.h"
#import "HXLiveModel.h"
#import "HXWatcherModel.h"
#import "HXCommentModel.h"


@interface HXWatchLiveViewModel : NSObject

@property (nonatomic, strong, readonly)  RACSignal *enterSignal;
@property (nonatomic, strong, readonly)  RACSignal *exitSignal;
@property (nonatomic, strong, readonly)  RACSignal *commentSignal;

@property (nonatomic, strong, readonly) RACCommand *enterRoomCommand;
@property (nonatomic, strong, readonly) RACCommand *leaveRoomCommand;

@property (nonatomic, strong) HXLiveModel *model;

@property (nonatomic, strong, readonly) NSString *roomID;

@property (nonatomic, strong, readonly) NSString *anchorAvatar;
@property (nonatomic, strong, readonly) NSString *anchorNickName;
@property (nonatomic, strong, readonly) NSString *viewCount;

@property (nonatomic, strong) NSArray<HXWatcherModel *> *watchers;
@property (nonatomic, strong) NSArray<HXCommentModel *> *comments;


- (instancetype)initWithRoomID:(NSString *)roomID;
- (void)addWatcher:(NSDictionary *)data;
- (void)addComment:(NSDictionary *)data;

@end
