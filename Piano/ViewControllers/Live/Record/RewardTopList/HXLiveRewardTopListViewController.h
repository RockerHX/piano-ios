//
//  HXLiveRewardTopListViewController.h
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


typedef NS_ENUM(NSUInteger, HXLiveRewardTopListType) {
    HXLiveRewardTopListTypeGift,
    HXLiveRewardTopListTypeAlbum,
};


@interface HXLiveRewardTopListViewController : UIViewController

@property (weak, nonatomic) IBOutlet      UIView *tapView;
@property (weak, nonatomic) IBOutlet      UIView *containerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong)                NSString *roomID;
@property (nonatomic, assign) HXLiveRewardTopListType  type;

- (void)showOnViewController:(UIViewController *)viewController;
- (void)dismiss;

@end
