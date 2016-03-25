//
//  HXWatcherContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatcherContainerViewController.h"
#import "HXWatcherCell.h"


@interface HXWatcherContainerViewController () <
HXWatcherCellDelegate
>
@end


@implementation HXWatcherContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXWatcherCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXWatcherCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

#pragma mark - HXWatcherCellDelegate Methods
- (void)commentCellShouldShowCommenter:(HXWatcherCell *)cell {
//    NSInteger row = [self.tableView indexPathForCell:cell].row;
    if (_delegate && [_delegate respondsToSelector:@selector(container:shouldShowWatcher:)]) {
        [_delegate container:self shouldShowWatcher:nil];
    }
}

@end
