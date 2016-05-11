//
//  HXWatchLiveBottomBar.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXWatchBottomBarAction) {
    HXWatchBottomBarActionComment,
    HXWatchBottomBarActionShare,
    HXWatchBottomBarActionGift,
};


@class HXWatchLiveBottomBar;


@protocol HXWatchLiveBottomBarDelegate <NSObject>

@required
- (void)bottomBar:(HXWatchLiveBottomBar *)bar takeAction:(HXWatchBottomBarAction)action;

@end


@interface HXWatchLiveBottomBar : UIView

@property (weak, nonatomic) IBOutlet       id  <HXWatchLiveBottomBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *giftButton;

- (IBAction)commentButtonPressed;
- (IBAction)shareButtonPressed;
- (IBAction)giftButtonPressed;

@end
