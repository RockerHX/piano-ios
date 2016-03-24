//
//  HXMainViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXLiveType) {
    HXLiveTypeWatchLive,
    HXLiveTypeReplay,
    HXLiveTypeLive,
};


@class HXLiveModel;


@interface HXMainViewController : UITabBarController

- (void)showLiveWithModel:(HXLiveModel *)model type:(HXLiveType)type;

@end
