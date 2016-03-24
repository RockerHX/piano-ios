//
//  HXWatchLiveContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXWatchLiveContainerViewController.h"
#import "HXWatchLiveCommentCell.h"


@interface HXWatchLiveContainerViewController () <
HXWatchLiveCommentCellDelegate
>
@end


@implementation HXWatchLiveContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXWatchLiveCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXWatchLiveCommentCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

#pragma mark - HXWatchLiveCommentCellDelegate Methods
- (void)commentCellShouldShowCommenter:(HXWatchLiveCommentCell *)cell {
//    NSInteger row = [self.tableView indexPathForCell:cell].row;
    if (_delegate && [_delegate respondsToSelector:@selector(container:shouldShowWatcher:)]) {
        [_delegate container:self shouldShowWatcher:nil];
    }
}

@end
