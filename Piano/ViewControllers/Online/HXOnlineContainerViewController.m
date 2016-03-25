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
        ;
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
//    return _viewModel.onlineList.count;
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlineCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _viewModel.cellHeight;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXOnlineCell *onlineCell = (HXOnlineCell *)cell;
//    [onlineCell displayCellWithModel:_viewModel.onlineList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXLiveModel *model = [[HXLiveModel alloc] initWithOnlineModel:_viewModel.onlineList[indexPath.row]];
    HXLiveModel *model = [HXLiveModel new];
    model.type = (HXLiveType)indexPath.row;
    if (_delegate && [_delegate respondsToSelector:@selector(container:showLiveByLiveModel:)]) {
        [_delegate container:self showLiveByLiveModel:model];
    }
}

@end
