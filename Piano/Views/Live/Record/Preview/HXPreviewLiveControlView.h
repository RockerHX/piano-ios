//
//  HXPreviewLiveControlView.h
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXPreviewLiveControlViewAction) {
    HXPreviewLiveControlViewActionFriendsCycle,
    HXPreviewLiveControlViewActionWeChat,
    HXPreviewLiveControlViewActionWeiBo,
    HXPreviewLiveControlViewActionStartLive,
};


@class HXPreviewLiveControlView;


@protocol HXPreviewLiveControlViewDelegate <NSObject>

@required
- (void)controlView:(HXPreviewLiveControlView *)controlView takeAction:(HXPreviewLiveControlViewAction)action;

@end


@interface HXPreviewLiveControlView : UIView

@property (weak, nonatomic) IBOutlet     id  <HXPreviewLiveControlViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet   UIView *container;
@property (weak, nonatomic) IBOutlet UIButton *startLiveButton;

- (IBAction)friendsCycleButtonPressed;
- (IBAction)wechatButtonPressed;
- (IBAction)weiboButtonPressed;
- (IBAction)startLiveButtonPressed;

@end
