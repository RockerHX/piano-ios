//
//  HXLiveBarrageContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveBarrageContainerViewController.h"
#import "HXLiveCommentBarrageCell.h"
#import "HXLiveSettingBarrageCell.h"
#import "UIView+Frame.h"


@interface HXLiveBarrageContainerViewController ()
@end


@implementation HXLiveBarrageContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Property
- (void)setBarrages:(NSArray *)barrages {
    _barrages = barrages;
    
    if (barrages.count) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(barrages.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _barrages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    HXBarrageModel *barrage = _barrages[indexPath.row];
    if (barrage.type == HXBarrageTypeComment) {
        cellIdentifier = NSStringFromClass([HXLiveCommentBarrageCell class]);
    } else {
        cellIdentifier = NSStringFromClass([HXLiveSettingBarrageCell class]);
    }
    return [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBarrageModel *barrage = _barrages[indexPath.row];
    NSString *cellIdentifier = NSStringFromClass((barrage.type == HXBarrageTypeComment) ? [HXLiveCommentBarrageCell class] : [HXLiveSettingBarrageCell class]);
    
    return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(HXLiveBarrageCell *cell) {
        [cell updateWithBarrage:_barrages[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(HXLiveBarrageCell *)cell updateWithBarrage:_barrages[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(barrageContainer:shouldShowBarrage:)]) {
        [_delegate barrageContainer:self shouldShowBarrage:_barrages[indexPath.row]];
    }
}

@end
