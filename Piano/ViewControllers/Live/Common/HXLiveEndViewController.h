//
//  HXLiveEndViewController.h
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXLiveEndViewController;


@protocol HXLiveEndViewControllerDelegate <NSObject>

@required
- (void)liveEndViewControllerWouldLikeExitRoom:(HXLiveEndViewController *)viewController;

@end


@interface HXLiveEndViewController : UIViewController

@property (weak, nonatomic) IBOutlet id  <HXLiveEndViewControllerDelegate>delegate;

- (IBAction)exitRoomButtonPressed;

@end
