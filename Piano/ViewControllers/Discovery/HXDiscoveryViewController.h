//
//  HXDiscoveryViewController.h
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


typedef NS_ENUM(NSUInteger, HXDiscoveryViewControllerAction) {
    HXDiscoveryViewControllerActionHiddenNavigationBar,
};


@protocol HXDiscoveryViewControllerDelegate;


@interface HXDiscoveryViewController : UIViewController

@property (weak, nonatomic) IBOutlet id  <HXDiscoveryViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *maskView;

- (void)startFetchList;

@end


@protocol HXDiscoveryViewControllerDelegate <NSObject>

@required
- (void)discoveryViewController:(HXDiscoveryViewController *)viewController takeAction:(HXDiscoveryViewControllerAction)action;

@end
