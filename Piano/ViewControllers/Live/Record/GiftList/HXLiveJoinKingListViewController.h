//
//  HXLiveJoinKingListViewController.h
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@interface HXLiveJoinKingListViewController : UIViewController

@property (weak, nonatomic) IBOutlet      UIView *tapView;
@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) NSString *roomID;

- (void)showOnViewController:(UIViewController *)viewController;
- (void)dismiss;

@end
