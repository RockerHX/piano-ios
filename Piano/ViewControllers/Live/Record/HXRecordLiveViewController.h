//
//  HXRecordLiveViewController.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXRecordAnchorView;


@interface HXRecordLiveViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *liveView;
@property (weak, nonatomic) IBOutlet UIView *previewContainer;
@property (weak, nonatomic) IBOutlet UIView *endCountContainer;

@property (weak, nonatomic) IBOutlet             UIView *topBar;
@property (weak, nonatomic) IBOutlet HXRecordAnchorView *anchorView;
@property (weak, nonatomic) IBOutlet             UIView *barragesView;
@property (weak, nonatomic) IBOutlet             UIView *bottomBar;

- (IBAction)closeButtonPressed;

@end
