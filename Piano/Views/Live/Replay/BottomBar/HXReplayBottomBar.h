//
//  HXReplayBottomBar.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXReplayBottomBarAction) {
    HXReplayBottomBarActionComment,
    HXReplayBottomBarActionForwarding,
};


@class HXReplayBottomBar;


@protocol HXReplayBottomBarDelegate <NSObject>

@required
- (void)bottomBar:(HXReplayBottomBar *)bar takeAction:(HXReplayBottomBarAction)action;

@end


@interface HXReplayBottomBar : UIView

@property (weak, nonatomic) IBOutlet id  <HXReplayBottomBarDelegate>delegate;

- (IBAction)commentButtonPressed;
- (IBAction)forwardingButtonPressed;

@end
