//
//  HXAlbumsContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsContainerViewController.h"
#import "HXAlbumsControlCell.h"
#import "HXAlbumsSongCell.h"
#import "HXAlbumsCommentCountCell.h"
#import "HXAlbumsCommentCell.h"


@interface HXAlbumsContainerViewController ()
@end


@implementation HXAlbumsContainerViewController

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

#pragma mark - Public Methods
- (void)refresh {
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXAlbumsRowTypeControl: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsControlCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsRowTypeSong: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsSongCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsRowTypeCommentCount: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCountCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsRowTypeComment: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXAlbumsRowTypeControl: {
            height = _viewModel.controlHeight;
            break;
        }
        case HXAlbumsRowTypeSong: {
            height = _viewModel.songHeight;
            break;
        }
        case HXAlbumsRowTypeCommentCount: {
            height = _viewModel.promptHeight;
            break;
        }
        case HXAlbumsRowTypeComment: {
            height = 70.0f;
//            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) cacheByIndexPath:indexPath configuration:^(HXAlbumsCommentCell *cell) {
//                ;
//            }];
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXAlbumsRowTypeControl: {
//            [(HXAlbumsControlCell *)cell ];
            break;
        }
        case HXAlbumsRowTypeSong: {
//            [(HXAlbumsSongCell *)cell ];
            break;
        }
        case HXAlbumsRowTypeCommentCount: {
//            [(HXAlbumsCommentCountCell *)cell ];
            break;
        }
        case HXAlbumsRowTypeComment: {
//            [(HXAlbumsCommentCell *)cell ];
            break;
        }
    }
}

@end
