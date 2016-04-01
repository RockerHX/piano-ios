//
//  HXProfileContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/30.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileContainerViewController.h"
#import "HXProfileHeaderCell.h"
#import "HXProfileLiveCell.h"
#import "HXProfileAlbumContainerCell.h"
#import "HXProfileVideoContainerCell.h"
#import "HXProfileReplayContainerCell.h"


@interface HXProfileContainerViewController ()
@end


@implementation HXProfileContainerViewController

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

#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(container:scrollOffset:)]) {
        [_delegate container:self scrollOffset:scrollView.contentOffset.y];
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXProfileRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    
    switch (rowType) {
        case HXProfileRowTypeHeader: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileHeaderCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileRowTypeLiving: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileLiveCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileRowTypeAlbumContainer: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileAlbumContainerCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileRowTypeVideoContainer: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileVideoContainerCell class]) forIndexPath:indexPath];
            break;
        }
        case HXProfileRowTypeReplayContainer: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXProfileReplayContainerCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXProfileRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXProfileRowTypeHeader: {
            height = _viewModel.headerHeight;
            break;
        }
        case HXProfileRowTypeLiving: {
            height = _viewModel.livingHeight;
            break;
        }
        case HXProfileRowTypeAlbumContainer: {
            height = _viewModel.albumHeight;
            break;
        }
        case HXProfileRowTypeVideoContainer: {
            height = _viewModel.videoHeight;
            break;
        }
        case HXProfileRowTypeReplayContainer: {
            height = _viewModel.replayHeight;
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
