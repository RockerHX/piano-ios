//
//  HXDiscoveryContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXDiscoveryViewModel.h"


@class HXDiscoveryContainerViewController;


@protocol HXDiscoveryContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXDiscoveryContainerViewController *)container scrollWithModel:(HXDiscoveryModel *)model;
- (void)container:(HXDiscoveryContainerViewController *)container showLiveByModel:(HXDiscoveryModel *)model;
- (void)container:(HXDiscoveryContainerViewController *)container showAnchorByModel:(HXDiscoveryModel *)model;

@end


@interface HXDiscoveryContainerViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet id  <HXDiscoveryContainerViewControllerDelegate>delegate;
@property (weak, nonatomic) HXDiscoveryViewModel *viewModel;

- (void)displayDiscoveryList;

@end
