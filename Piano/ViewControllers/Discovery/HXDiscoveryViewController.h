//
//  HXDiscoveryViewController.h
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXDiscoveryViewController;


@protocol HXDiscoveryViewControllerDelegate <NSObject>

@required
- (void)discoveryViewControllerHandleMenu:(HXDiscoveryViewController *)viewController;

@end


@interface HXDiscoveryViewController : UIViewController

@property (weak, nonatomic) IBOutlet id  <HXDiscoveryViewControllerDelegate>delegate;

- (void)startFetchList;

@end
