//
//  HXWatcherContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXWatcherContainerViewController;


@protocol HXWatcherContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXWatcherContainerViewController *)container shouldShowWatcher:(id)watcher;

@end


@interface HXWatcherContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXWatcherContainerViewControllerDelegate>delegate;

@end
