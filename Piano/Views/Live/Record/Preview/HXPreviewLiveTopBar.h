//
//  HXPreviewLiveTopBar.h
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXPreviewLiveTopBarAction) {
    HXPreviewLiveTopBarActionBeauty,
    HXPreviewLiveTopBarActionChange,
    HXPreviewLiveTopBarActionColse,
};


@class HXPreviewLiveTopBar;


@protocol HXPreviewLiveTopBarDelegate <NSObject>

@required
- (void)topBar:(HXPreviewLiveTopBar *)bar takeAction:(HXPreviewLiveTopBarAction)action;

@end


@interface HXPreviewLiveTopBar : UIView

@property (weak, nonatomic) IBOutlet       id  <HXPreviewLiveTopBarDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *beautyButton;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (IBAction)beautyButtonPressed;
- (IBAction)changeButtonPressed;
- (IBAction)closeButtonPressed;

@end
