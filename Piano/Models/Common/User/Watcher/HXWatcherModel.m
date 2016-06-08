//
//  HXWatcherModel.m
//  Piano
//
//  Created by miaios on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherModel.h"
#import "HXCommentModel.h"
#import "HXLiveModel.h"


@implementation HXWatcherModel

#pragma mark - Class Methods
+ (instancetype)instanceWithComment:(HXCommentModel *)comment {
    HXWatcherModel *watcher = [HXWatcherModel new];
    watcher.ID = comment.uID;
    watcher.avatarUrl = comment.avatarUrl;
    watcher.nickName = comment.nickName;
    watcher.signature = comment.signature;
    return watcher;
}

+ (instancetype)instanceWithLiveModel:(HXLiveModel *)liveModel {
    HXWatcherModel *watcher = [HXWatcherModel new];
    watcher.ID = liveModel.uID;
    watcher.avatarUrl = liveModel.avatarUrl;
    watcher.nickName = liveModel.nickName;
    watcher.signature = liveModel.signature;
    return watcher;
}

@end
