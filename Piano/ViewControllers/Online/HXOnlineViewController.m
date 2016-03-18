//
//  HXOnlineViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXOnlineViewController.h"
#import "MJRefresh.h"
#import "MiaAPIHelper.h"
#import "HXOnlineCell.h"
#import "HXMainViewController.h"


@interface HXOnlineViewController ()

@end


@implementation HXOnlineViewController {
    NSArray *_onlineList;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameOnline;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXOnlineNavigationController";
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(fetchOnlineList)];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)startFetchOnlineList {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Private Methods
- (void)fetchOnlineList {
    [MiaAPIHelper getRoomListWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSArray *roomList = userInfo[@"v"][@"data"];
            [self fetchedListData:roomList];
        } else {
            NSLog(@"getRoomList failed");
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        NSLog(@"getRoomList timeout");
    }];
}

- (void)fetchedListData:(NSArray *)list {
    NSMutableArray *onlieList = @[].mutableCopy;
    for (NSDictionary *data in list) {
        HXOnlineModel *model = [HXOnlineModel mj_objectWithKeyValues:data];
        [onlieList addObject:model];
    }
    _onlineList = [onlieList copy];
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _onlineList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXOnlineCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXOnlineCell *onlineCell = (HXOnlineCell *)cell;
    [onlineCell displayCellWithModel:_onlineList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HXLiveModel *model = [[HXLiveModel alloc] initWithOnlineModel:_onlineList[indexPath.row]];
    [(HXMainViewController *)self.tabBarController showLiveWithModel:model];
}

@end
