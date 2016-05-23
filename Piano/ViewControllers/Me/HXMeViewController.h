//
//  HXMeViewController.h
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@protocol HXMeViewControllerDelegate;


@interface HXMeViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXMeViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *coverView;

- (void)refresh;

@end


@protocol HXMeViewControllerDelegate <NSObject>

@required
- (void)meViewControllerHiddenNavigationBar:(HXMeViewController *)viewController;

@end
