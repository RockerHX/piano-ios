//
//  HXProfileContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXProfileContainerViewController;


@protocol HXProfileContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXProfileContainerViewController *)container scrollOffset:(CGFloat)offset;

@end

@interface HXProfileContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXProfileContainerViewControllerDelegate>delegate;

@end
