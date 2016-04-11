//
//  HXLiveCommentContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXCommentModel;
@class HXLiveCommentContainerViewController;


@protocol HXLiveCommentContainerViewControllerDelegate <NSObject>

@required
- (void)commentContainer:(HXLiveCommentContainerViewController *)container shouldShowComment:(HXCommentModel *)comment;

@end


@interface HXLiveCommentContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXLiveCommentContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *comments;

@end
