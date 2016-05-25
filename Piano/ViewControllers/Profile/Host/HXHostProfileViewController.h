//
//  HXHostProfileViewController.h
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@protocol HXHostProfileViewControllerDelegate;


@interface HXHostProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXHostProfileViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *coverView;

- (void)refresh;

@end


@protocol HXHostProfileViewControllerDelegate <NSObject>

@required
- (void)meViewControllerHiddenNavigationBar:(HXHostProfileViewController *)viewController;

@end
