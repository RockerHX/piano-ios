//
//  HXPlayViewController.h
//  mia
//
//  Created by miaios on 16/2/25.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@class HXPlayTopBar;
@class HXPlayBottomBar;
@class HXPlaySummaryView;

@interface HXPlayViewController : UIViewController

@property (weak, nonatomic) IBOutlet       UIImageView *coverBG;
@property (weak, nonatomic) IBOutlet      HXPlayTopBar *topBar;
@property (weak, nonatomic) IBOutlet HXPlaySummaryView *summaryView;
@property (weak, nonatomic) IBOutlet   HXPlayBottomBar *bottomBar;

@end
