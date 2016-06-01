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
#import "HXSelectedAlbumContainerViewController.h"


static NSInteger FetchLimit = 10;


@interface HXSelectedAlbumViewController () <
HXSelectedAlbumContainerViewControllerDelegate
>
@end


@implementation HXSelectedAlbumViewController {
    NSInteger _start;
    NSMutableArray *_albumList;
    BOOL _selectedIndex;
    
    HXSelectedAlbumContainerViewController *_container;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _container = segue.destinationViewController;
    _container.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _albumList = @[].mutableCopy;
    
    [self fetchAlbumList];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)closeButtonPressed {
    [self dismiss];
}

- (IBAction)enterButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(selectedAlbumViewController:selectedAlbum:)]) {
        [_delegate selectedAlbumViewController:self selectedAlbum:_albumList[_selectedIndex]];
    }
    [self dismiss];
}

#pragma mark - Private Methods
- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)fetchAlbumList {
    [self showHUD];
    
    [MiaAPIHelper liveGetAlbumListWithUID:[HXUserSession session].uid start:_start limit:FetchLimit completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         if (success) {
             _start += FetchLimit;
             [self parseList:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
         }
         [self hiddenHUD];
     } timeoutBlock:^(MiaRequestItem *requestItem) {
         [self showBannerWithPrompt:TimtOutPrompt];
         [self hiddenHUD];
     }];
}

- (void)parseList:(NSArray *)list {
    for (NSDictionary *data in list) {
        HXAlbumModel *model = [HXAlbumModel mj_objectWithKeyValues:data];
        [_albumList addObject:model];
    }
    _container.albums = _albumList;
}

#pragma mark - HXSelectedAlbumContainerViewControllerDelegate Methods
- (void)container:(HXSelectedAlbumContainerViewController *)contianer selectedIndex:(NSInteger)index {
    _selectedIndex = index;
}

@end
