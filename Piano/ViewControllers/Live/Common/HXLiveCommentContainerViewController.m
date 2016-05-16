//
//  HXLiveCommentContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveCommentContainerViewController.h"
#import "HXLiveCommentCell.h"


@interface HXLiveCommentContainerViewController () <
HXLiveCommentCellDelegate
>
@end


@implementation HXLiveCommentContainerViewController

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
- (void)setComments:(NSArray *)comments {
    _comments = comments;
    
    if (comments.count) {
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(comments.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXLiveCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXLiveCommentCell class]) forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXLiveCommentCell class]) cacheByIndexPath:indexPath configuration:^(HXLiveCommentCell *cell) {
        [cell updateWithModel:_comments[indexPath.row]];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [(HXLiveCommentCell *)cell updateWithModel:_comments[indexPath.row]];
}

#pragma mark - HXLiveCommentCellDelegate Methods
- (void)commentCellShouldShowCommenter:(HXLiveCommentCell *)cell {
    NSInteger row = [self.tableView indexPathForCell:cell].row;
    if (_delegate && [_delegate respondsToSelector:@selector(commentContainer:shouldShowComment:)]) {
        [_delegate commentContainer:self shouldShowComment:_comments[row]];
    }
}

@end
