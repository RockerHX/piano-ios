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
    HXWatchBottomBarActionAlbum,
    HXWatchBottomBarActionFreeGift,
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
@property (weak, nonatomic) IBOutlet UIButton *albumButton;
@property (weak, nonatomic) IBOutlet UIButton *freeGiftButton;

- (IBAction)commentButtonPressed;
- (IBAction)shareButtonPressed;
- (IBAction)giftButtonPressed;
- (IBAction)albumButtonPressed;
- (IBAction)freeGiftButtonPressed;

@end
