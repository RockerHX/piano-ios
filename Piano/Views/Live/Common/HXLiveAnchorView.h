//
//  HXLiveAnchorView.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HXLiveAnchorViewAction) {
    HXLiveAnchorViewActionShowAnchor,
    HXLiveAnchorViewActionAttention,
};


@class HXLiveAnchorView;


@protocol HXLiveAnchorViewDelegate <NSObject>

@required
- (void)anchorView:(HXLiveAnchorView *)anchorView takeAction:(HXLiveAnchorViewAction)action;

@end


@interface HXLiveAnchorView : UIView

@property (weak, nonatomic) IBOutlet id  <HXLiveAnchorViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *anchorAvatar;
@property (weak, nonatomic) IBOutlet  UILabel *anchorNickNameLabel;
@property (weak, nonatomic) IBOutlet  UILabel *watcherCountLabel;

- (IBAction)anchorAvatarPressed;
- (IBAction)attentionButtonPressed;

@end
