//
//  HXPreviewLiveViewController.h
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXLiveModel;
@class HXPreviewLiveEidtView;
@class HXPreviewLiveControlView;
@class HXPreviewLiveViewController;


@protocol HXPreviewLiveViewControllerDelegate <NSObject>

@required
- (void)previewControllerHandleFinishedShouldStartLive:(HXPreviewLiveViewController *)viewController
                                             liveModel:(HXLiveModel *)model
                                           frontCamera:(BOOL)frontCamera
                                                beauty:(BOOL)beauty;

- (void)previewControllerClosed:(HXPreviewLiveViewController *)viewController;

@end


@interface HXPreviewLiveViewController : UIViewController

@property (weak, nonatomic) IBOutlet                       id  <HXPreviewLiveViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet                   UIView *controlContainerView;
@property (weak, nonatomic) IBOutlet    HXPreviewLiveEidtView *editView;
@property (weak, nonatomic) IBOutlet HXPreviewLiveControlView *countDownContainerView;

@end
