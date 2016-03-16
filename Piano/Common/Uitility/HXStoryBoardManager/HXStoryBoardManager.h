//
//  HXStoryBoardManager.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXStoryBoardName) {
    HXStoryBoardNameLogin,
    HXStoryBoardNameDiscovery,
    HXStoryBoardNameFavorite,
    HXStoryBoardNameMe,
    HXStoryBoardNameSetting,
    HXStoryBoardNameProfile,
    HXStoryBoardNamePlay,
    HXStoryBoardNameShare,
    HXStoryBoardNameMessageCenter,
    HXStoryBoardNameMusicDetail,
};

@interface HXStoryBoardManager : NSObject

+ (__kindof UIViewController *)navigaitonControllerWithIdentifier:(NSString *)identifier storyBoardName:(HXStoryBoardName)name;
+ (__kindof UIViewController *)viewControllerWithClass:(Class)class storyBoardName:(HXStoryBoardName)name;

@end
