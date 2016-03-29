//
//  HXMeContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeContainerViewController.h"
#import "HXMeViewModel.h"


@interface HXMeContainerViewController ()
@end


@implementation HXMeContainerViewController {
    HXMeViewModel *_viewModel;
}

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

#pragma mark - Table View Data Source Methods
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _viewModel.rows;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = nil;
////    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
////    
////    switch (rowType) {
////        case HXAlbumsRowTypeControl: {
////            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsControlCell class]) forIndexPath:indexPath];
////            break;
////        }
////        case HXAlbumsRowTypeSong: {
////            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsSongCell class]) forIndexPath:indexPath];
////            break;
////        }
////        case HXAlbumsRowTypeCommentCount: {
////            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCountCell class]) forIndexPath:indexPath];
////            break;
////        }
////        case HXAlbumsRowTypeComment: {
////            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXAlbumsCommentCell class]) forIndexPath:indexPath];
////            break;
////        }
////    }
//    return cell;
//}
//
//#pragma mark - Table View Delegate Methods
////- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
////    CGFloat height = 0.0f;
////    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
////    return height;
////}
//
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
////    HXAlbumsRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
