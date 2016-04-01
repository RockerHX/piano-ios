//
//  HXOnlineContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXOnlineModel.h"


@class HXOnlineContainerViewController;


@protocol HXOnlineContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXOnlineContainerViewController *)container showLiveByModel:(HXOnlineModel *)model;
- (void)container:(HXOnlineContainerViewController *)container showAnchorByModel:(HXOnlineModel *)model;

@end


@interface HXOnlineContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXOnlineContainerViewControllerDelegate>delegate;

- (void)startFetchOnlineList;

@end
