//
//  HXLiveRewardTopListViewController.m
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveRewardTopListViewController.h"
#import "BlocksKit+UIKit.h"
#import "UIView+Frame.h"
#import "MiaAPIHelper.h"
#import "HXLiveRewardTopCell.h"


@interface HXLiveRewardTopListViewController () <
UITableViewDataSource,
UITableViewDelegate
>
@end


@implementation HXLiveRewardTopListViewController {
    NSArray *_topList;
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
    switch (_type) {
        case HXLiveRewardTopListTypeGift: {
            [MiaAPIHelper getGiftTopListWithRoomID:_roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                if (success) {
                    [self parseLists:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                }
            } timeoutBlock:^(MiaRequestItem *requestItem) {
                [self timeOutPrompt];
            }];
            break;
        }
        case HXLiveRewardTopListTypeAlbum: {
            [MiaAPIHelper getAlbumTopListWithRoomID:_roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                if (success) {
                    [self parseLists:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
                }
            } timeoutBlock:^(MiaRequestItem *requestItem) {
                [self timeOutPrompt];
            }];
            break;
        }
    }
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

- (void)parseLists:(NSArray *)lists {
    NSMutableArray *topList = @[].mutableCopy;
    [lists enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL * _Nonnull stop) {
        HXLiveRewardTopModel *top = [HXLiveRewardTopModel mj_objectWithKeyValues:data];
        top.index = (idx + 1);
        [topList addObject:top];
    }];
    _topList = [topList copy];
    [_tableView reloadData];
}

- (void)timeOutPrompt {
    [self showBannerWithPrompt:TimtOutPrompt];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _topList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXLiveRewardTopCell class]) forIndexPath:indexPath];
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXLiveRewardTopCell *rewardTopCell = (HXLiveRewardTopCell *)cell;
    [rewardTopCell updateWithTop:_topList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

@end
