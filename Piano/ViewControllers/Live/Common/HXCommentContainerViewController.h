//
//  HXCommentContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXCommentModel;
@class HXCommentContainerViewController;


@protocol HXCommentContainerViewControllerDelegate <NSObject>

@required
- (void)commentContainer:(HXCommentContainerViewController *)container shouldShowComment:(HXCommentModel *)comment;

@end


@interface HXCommentContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXCommentContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *comments;

@end
