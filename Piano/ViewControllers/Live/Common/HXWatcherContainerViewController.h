//
//  HXWatcherContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXWatcherModel;
@class HXWatcherContainerViewController;


@protocol HXWatcherContainerViewControllerDelegate <NSObject>

@required
- (void)watcherContainer:(HXWatcherContainerViewController *)container shouldShowWatcher:(HXWatcherModel *)watcher;

@end


@interface HXWatcherContainerViewController : UICollectionViewController

@property (weak, nonatomic) IBOutlet id  <HXWatcherContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *watchers;

@end
