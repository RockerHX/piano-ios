//
//  HXDiscoveryViewController.h
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


typedef NS_ENUM(BOOL, HXDiscoveryMenuState) {
    HXDiscoveryMenuStateClose,
    HXDiscoveryMenuStateOpen,
};


typedef NS_ENUM(NSUInteger, HXDiscoveryViewControllerAction) {
    HXDiscoveryViewControllerActionMenuClose,
    HXDiscoveryViewControllerActionMenuOpen,
};


@class HXDiscoveryViewController;


@protocol HXDiscoveryViewControllerDelegate <NSObject>

@required
- (void)discoveryViewController:(HXDiscoveryViewController *)viewController action:(HXDiscoveryViewControllerAction)action;

@end


@interface HXDiscoveryViewController : UIViewController

@property (weak, nonatomic) IBOutlet id  <HXDiscoveryViewControllerDelegate>delegate;

@property (nonatomic, assign, readonly) HXDiscoveryMenuState menuState;

- (void)startFetchList;

@end
