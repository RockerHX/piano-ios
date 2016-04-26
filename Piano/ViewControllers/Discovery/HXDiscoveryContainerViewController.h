//
//  HXDiscoveryContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXDiscoveryModel.h"


@class HXDiscoveryContainerViewController;


@protocol HXDiscoveryContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXDiscoveryContainerViewController *)container showLiveByModel:(HXDiscoveryModel *)model;
- (void)container:(HXDiscoveryContainerViewController *)container showAnchorByModel:(HXDiscoveryModel *)model;

@end


@interface HXDiscoveryContainerViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet id  <HXDiscoveryContainerViewControllerDelegate>delegate;

- (void)startFetchDiscoveryList;

@end
