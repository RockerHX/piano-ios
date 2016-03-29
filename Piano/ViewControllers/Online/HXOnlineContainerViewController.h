//
//  HXOnlineContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"
#import "HXLiveModel.h"


@class HXOnlineContainerViewController;


@protocol HXOnlineContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXOnlineContainerViewController *)container showLiveByLiveModel:(HXLiveModel *)model;

@end


@interface HXOnlineContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXOnlineContainerViewControllerDelegate>delegate;

- (void)startFetchOnlineList;

@end
