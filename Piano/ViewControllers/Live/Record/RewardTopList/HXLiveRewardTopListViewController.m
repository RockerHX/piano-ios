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
            _titleLabel.text = @"本场10大捧场王";
            _promptLabel.text = @"还没有收到礼物";
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
            _titleLabel.text = @"本场专辑打赏排行";
            _promptLabel.text = @"还没有人打赏这版专辑";
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

#pragma mark - Private Methods
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)parseLists:(NSArray *)lists {
    NSMutableArray *topList = @[].mutableCopy;
    [lists enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger idx, BOOL * _Nonnull stop) {
        HXLiveRewardTopModel *top = [HXLiveRewardTopModel mj_objectWithKeyValues:data];
        top.index = (idx + 1);
        [topList addObject:top];
    }];
    _topList = [topList copy];
    
    BOOL hasData = topList.count;
    if (hasData) {
        _promptLabel.hidden = YES;
        _tableView.hidden = NO;
        [_tableView reloadData];
    }
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
