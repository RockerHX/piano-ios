//
//  HXWatchLiveContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXWatchLiveContainerViewController;


@protocol HXWatchLiveContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXWatchLiveContainerViewController *)container shouldShowWatcher:(id)watcher;

@end


@interface HXWatchLiveContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXWatchLiveContainerViewControllerDelegate>delegate;

@end
