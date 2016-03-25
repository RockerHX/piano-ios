//
//  HXReplayViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXLiveModel;


@interface HXReplayViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *liveView;

@property (nonatomic, strong) HXLiveModel *model;

- (IBAction)closeButtonPressed;

@end
