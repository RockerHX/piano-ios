//
//  HXLiveBarrageContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveBarrageContainerViewController.h"
#import "HXLiveBarrageCell.h"


@interface HXLiveBarrageContainerViewController () <
HXLiveBarrageCellDelegate
>
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
    HXLiveBarrageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXLiveBarrageCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXLiveBarrageCell class]) cacheByIndexPath:indexPath configuration:^(HXLiveBarrageCell *cell) {
        [cell updateWithBarrage:_barrages[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(HXLiveBarrageCell *)cell updateWithBarrage:_barrages[indexPath.row]];
}

#pragma mark - HXLiveBarrageCellDelegate Methods
- (void)commentCellShouldShowCommenter:(HXLiveBarrageCell *)cell {
    NSInteger row = [self.tableView indexPathForCell:cell].row;
    if (_delegate && [_delegate respondsToSelector:@selector(commentContainer:shouldShowComment:)]) {
        [_delegate commentContainer:self shouldShowComment:_barrages[row]];
    }
}

@end
