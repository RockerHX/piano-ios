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

@property (nonatomic, strong, readonly) RACCommand *enterRoomCommand;
@property (nonatomic, strong, readonly) RACCommand *leaveRoomCommand;

@property (nonatomic, strong, readonly) NSString *anchorAvatar;
@property (nonatomic, strong, readonly) NSString *anchorNickName;
@property (nonatomic, strong, readonly) NSString *viewCount;

- (instancetype)initWithRoomID:(NSString *)roomID;

@end
