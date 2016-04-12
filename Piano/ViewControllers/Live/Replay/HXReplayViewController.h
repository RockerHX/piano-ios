//
//  HXReplayViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXDiscoveryModel;
@class HXLiveAnchorView;
@class HXReplayBottomBar;


@interface HXReplayViewController : UIViewController

@property (weak, nonatomic) IBOutlet            UIView *replayView;
@property (weak, nonatomic) IBOutlet  HXLiveAnchorView *anchorView;
@property (weak, nonatomic) IBOutlet HXReplayBottomBar *bottomBar;

@property (nonatomic, strong) HXDiscoveryModel *model;

- (IBAction)closeButtonPressed;

@end
