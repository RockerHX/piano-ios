//
//  HXStoryBoardManager.m
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import "HXStoryBoardManager.h"

@implementation HXStoryBoardManager

+ (__kindof UIViewController *)navigaitonControllerWithIdentifier:(NSString *)identifier storyBoardName:(HXStoryBoardName)name {
    id controller = [self viewControllerWithIdentifier:identifier storyBoardName:name];
    return [controller isKindOfClass:[UINavigationController class]] ? controller : nil;
}

+ (__kindof UIViewController *)viewControllerWithClass:(Class)class storyBoardName:(HXStoryBoardName)name {
    NSString *identifier = NSStringFromClass([class class]);
    id controller = [self viewControllerWithIdentifier:identifier storyBoardName:name];
    return [controller isKindOfClass:[UIViewController class]] ? controller : nil;
}

#pragma mark - Private Methods
+ (NSString *)storyBoardName:(HXStoryBoardName)name {
    NSString *storyBoardName = nil;
    switch (name) {
        case HXStoryBoardNameLive: {
            storyBoardName = @"Live";
            break;
        }
        case HXStoryBoardNameReplay: {
            storyBoardName = @"Replay";
            break;
        }
        case HXStoryBoardNamePublish: {
            storyBoardName = @"Publish";
            break;
        }
        case HXStoryBoardNameSetting: {
            storyBoardName = @"Setting";
            break;
        }
    }
    return storyBoardName;
}

+ (UIViewController *)viewControllerWithIdentifier:(NSString *)identifier storyBoardName:(HXStoryBoardName)name {
    UIViewController *viewController = nil;
    @try {
        NSString *storyBoardName = [self storyBoardName:name];
        viewController = [[UIStoryboard storyboardWithName:storyBoardName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
    }
    @catch (NSException *exception) {
        NSLog(@"Load View Controller From StoryBoard Error:%@", exception.reason);
    }
    @finally {
        return viewController;
    }
}

@end
