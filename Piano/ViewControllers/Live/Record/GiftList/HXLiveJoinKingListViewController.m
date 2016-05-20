//
//  HXLiveJoinKingListViewController.m
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveJoinKingListViewController.h"
#import "BlocksKit+UIKit.h"
#import "UIView+Frame.h"
#import "MiaAPIHelper.h"
#import "HXLiveJoinKingCell.h"


@interface HXLiveJoinKingListViewController () <
UITableViewDataSource,
UITableViewDelegate
>
@end


@implementation HXLiveJoinKingListViewController {
    NSArray *_kingList;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self popUp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    __weak __typeof__(self)weakSelf = self;
    [_tapView bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf dismiss];
    }];
}

- (void)viewConfigure {
    [self showHUD];
    [MiaAPIHelper getGiftTopListWithRoomID:_roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSMutableArray *kingList = @[].mutableCopy;
            NSArray *lists = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            [lists enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL * _Nonnull stop) {
                HXLiveJoinKingModel *king = [HXLiveJoinKingModel mj_objectWithKeyValues:data];
                king.index = (idx + 1);
                [kingList addObject:king];
            }];
            _kingList = [kingList copy];
            [_tableView reloadData];
        }
        [self hiddenHUD];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self showBannerWithPrompt:TimtOutPrompt];
        [self hiddenHUD];
    }];
}

#pragma mark - Public Methods
- (void)showOnViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)dismiss {
    _bottomConstraint.constant = 0.0f;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark - Private Methods
- (void)popUp {
    _bottomConstraint.constant = _containerView.height;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _kingList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXLiveJoinKingCell class]) forIndexPath:indexPath];
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXLiveJoinKingCell *joinKingCell = (HXLiveJoinKingCell *)cell;
    [joinKingCell updateWithKing:_kingList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

@end
