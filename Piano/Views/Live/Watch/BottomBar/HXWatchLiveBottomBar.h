//
//  HXWatchLiveBottomBar.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXWatchLiveBottomBarAction) {
    HXWatchLiveBottomBarActionComment,
    HXWatchLiveBottomBarActionForwarding,
};


@class HXWatchLiveBottomBar;


@protocol HXWatchLiveBottomBarDelegate <NSObject>

@required
- (void)bottomBar:(HXWatchLiveBottomBar *)bar takeAction:(HXWatchLiveBottomBarAction)action;

@end


@interface HXWatchLiveBottomBar : UIView

@property (weak, nonatomic) IBOutlet id  <HXWatchLiveBottomBarDelegate>delegate;

- (IBAction)commentButtonPressed;
- (IBAction)forwardingButtonPressed;

@end
