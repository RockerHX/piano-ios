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
#import "HXAlbumsViewModel.h"


@interface HXAlbumsContainerViewController ()
@end


@implementation HXAlbumsContainerViewController {
    HXAlbumsViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _viewModel = [HXAlbumsViewModel new];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    HXAlbumsCellRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXAlbumsCellRowTypeControl: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsControlCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsCellRowTypeSong: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsSongCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsCellRowTypeCommentCount: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCountCell class]) forIndexPath:indexPath];
            break;
        }
        case HXAlbumsCellRowTypeComment: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXAlbumsCellRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXAlbumsCellRowTypeControl: {
            height = _viewModel.controlHeight;
            break;
        }
        case HXAlbumsCellRowTypeSong: {
            height = _viewModel.songHeight;
            break;
        }
        case HXAlbumsCellRowTypeCommentCount: {
            height = _viewModel.promptHeight;
            break;
        }
        case HXAlbumsCellRowTypeComment: {
            height = [tableView fd_heightForCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) cacheByIndexPath:indexPath configuration:^(HXAlbumsCommentCell *cell) {
                ;
            }];
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXAlbumsCellRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXAlbumsCellRowTypeControl: {
            ;
            break;
        }
        case HXAlbumsCellRowTypeSong: {
            ;
            break;
        }
        case HXAlbumsCellRowTypeCommentCount: {
            ;
            break;
        }
        case HXAlbumsCellRowTypeComment: {
            ;
            break;
        }
    }
}

@end
