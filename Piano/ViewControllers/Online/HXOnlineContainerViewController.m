//
//  HXOnlineContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineContainerViewController.h"
#import "MJRefresh.h"
#import "HXOnlineViewModel.h"
#import "HXOnlineCell.h"
#import "HXOnlineReplayCell.h"
#import "HXOnlineNewEntryCell.h"
#import "HXOnlineVideoCell.h"
#import "HXAlertBanner.h"


@interface HXOnlineContainerViewController ()
@end


@implementation HXOnlineContainerViewController {
    HXOnlineViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _viewModel = [[HXOnlineViewModel alloc] init];
}

- (void)viewConfigure {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchOnlineList)];
}

#pragma mark - Public Methods
- (void)startFetchOnlineList {
    [self.tableView.mj_header beginRefreshing];
}

- (void)fetchOnlineList {
    @weakify(self)
    RACSignal *requestSiganl = [_viewModel.requestCommand execute:nil];
    [requestSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        [self endLoad];
    }];
}

#pragma mark - Private Methods
- (void)endLoad {
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.onlineList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (_viewModel.onlineList[indexPath.row].type) {
        case HXOnlineTypeLive: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlineCell class]) forIndexPath:indexPath];
            break;
        }
        case HXOnlineTypeReplay: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlineReplayCell class]) forIndexPath:indexPath];
            break;
        }
        case HXOnlineTypeNewEntry: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlineNewEntryCell class]) forIndexPath:indexPath];
            break;
        }
        case HXOnlineTypeVideo: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlineVideoCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _viewModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXOnlineModel *model = _viewModel.onlineList[indexPath.row];
    switch (model.type) {
        case HXOnlineTypeLive: {
            HXOnlineCell *onlineCell = (HXOnlineCell *)cell;
            [onlineCell updateCellWithModel:model];
            break;
        }
        case HXOnlineTypeReplay: {
            break;
        }
        case HXOnlineTypeNewEntry: {
            break;
        }
        case HXOnlineTypeVideo: {
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(container:showLiveByModel:)]) {
        [_delegate container:self showLiveByModel:_viewModel.onlineList[indexPath.row]];
    }
}

@end
