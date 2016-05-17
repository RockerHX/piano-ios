//
//  HXSelectedAlbumViewController.m
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSelectedAlbumViewController.h"
#import "BlocksKit+UIKit.h"
#import "UIView+Frame.h"
#import "HXPreviewSelectedAlbumCell.h"
#import "MiaAPIHelper.h"
#import "HXUserSession.h"


static NSInteger FetchLimit = 10;


@interface HXSelectedAlbumViewController ()
@end


@implementation HXSelectedAlbumViewController {
    NSInteger _start;
    NSMutableArray *_albumList;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self popUpAnimation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _albumList = @[].mutableCopy;
    __weak __typeof__(self)weakSelf = self;
    [_tapView bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf dismiss];
    }];
    
    [self fetchAlbumList];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)showOnViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

- (void)dismiss {
    _bottomConstraint.constant = 0.0f;
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
}

#pragma mark - Private Methods
- (void)popUpAnimation {
    _bottomConstraint.constant = _containerView.height;
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.view layoutIfNeeded];
    } completion:nil];
}

- (void)fetchAlbumList {
    [MiaAPIHelper liveGetAlbumListWithUID:[HXUserSession session].uid start:_start limit:FetchLimit completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         _start += FetchLimit;
         [self parseList:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        ;
    }];
}

- (void)parseList:(NSArray *)list {
    for (NSDictionary *data in list) {
        HXAlbumModel *model = [HXAlbumModel mj_objectWithKeyValues:data];
        [_albumList addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXPreviewSelectedAlbumCell class]) forIndexPath:indexPath];
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXPreviewSelectedAlbumCell *selectedCell = (HXPreviewSelectedAlbumCell *)cell;
    [selectedCell displayWithAlbum:_albumList[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_delegate && [_delegate respondsToSelector:@selector(selectedAlbumViewController:selectedAlbum:)]) {
        [_delegate selectedAlbumViewController:self selectedAlbum:_albumList[indexPath.row]];
    }
    [self dismiss];
}

@end
