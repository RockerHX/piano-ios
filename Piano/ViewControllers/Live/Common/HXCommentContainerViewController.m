//
//  HXCommentContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXCommentContainerViewController.h"
#import "HXLiveCommentCell.h"


@interface HXCommentContainerViewController () <
HXLiveCommentCellDelegate
>
@end


@implementation HXCommentContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
}

- (void)viewConfigure {
    ;
}
#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXLiveCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXLiveCommentCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

#pragma mark - HXLiveCommentCellDelegate Methods
- (void)commentCellShouldShowCommenter:(HXLiveCommentCell *)cell {
//    NSInteger row = [self.tableView indexPathForCell:cell].row;
    if (_delegate && [_delegate respondsToSelector:@selector(container:shouldShowWatcher:)]) {
        [_delegate container:self shouldShowWatcher:nil];
    }
}

@end
