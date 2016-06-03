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

@property (weak, nonatomic) IBOutlet       id  <HXLiveAnchorViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *avatar;
@property (weak, nonatomic) IBOutlet  UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet  UILabel *countPromptLabel;
@property (weak, nonatomic) IBOutlet  UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *attentionButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attentionButtonLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attentionButtonWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *attentionButtonRightConstraint;

@property (nonatomic, assign) BOOL  attented;
@property (nonatomic, assign) BOOL  ownside;
@property (nonatomic, assign) BOOL  replay;

- (IBAction)avatarButtonPressed;
- (IBAction)attentionButtonPressed;

@end
