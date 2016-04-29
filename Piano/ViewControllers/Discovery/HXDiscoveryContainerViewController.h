//
//  HXDiscoveryContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXDiscoveryViewModel.h"


typedef NS_ENUM(NSUInteger, HXDiscoveryContainerAction) {
    HXDiscoveryContainerActionScroll,
    HXDiscoveryContainerActionShowLive,
    HXDiscoveryContainerActionShowStation,
};


@class HXDiscoveryContainerViewController;


@protocol HXDiscoveryContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXDiscoveryContainerViewController *)container takeAction:(HXDiscoveryContainerAction)action model:(HXDiscoveryModel *)model;

@end


@interface HXDiscoveryContainerViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet id  <HXDiscoveryContainerViewControllerDelegate>delegate;
@property (weak, nonatomic) HXDiscoveryViewModel *viewModel;

- (void)displayDiscoveryList;

@end
