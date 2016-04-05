//
//  HXAlbumsViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsViewController.h"
#import "HXAlbumsContainerViewController.h"
#import "HXAlbumsNavigationBar.h"


@interface HXAlbumsViewController () <
HXAlbumsContainerViewControllerDelegate,
HXAlbumsNavigationBarDelegate
>
@end


@implementation HXAlbumsViewController {
    HXAlbumsContainerViewController *_containerViewController;
    HXAlbumsViewModel *_viewModel;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameAlbums;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXAlbumsNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [self showHUD];
    
    _viewModel = [[HXAlbumsViewModel alloc] initWithAlbumID:_albumID];
    _containerViewController.viewModel = _viewModel;
    
    @weakify(self)
    RACSignal *fetchSignal = [_viewModel.fetchCommand execute:nil];
    [fetchSignal subscribeError:^(NSError *error) {
        @strongify(self)
        [self hiddenHUD];
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        [self->_containerViewController refresh];
    }];
}

- (void)viewConfigure {
    ;
}

#pragma mark - HXAlbumsContainerViewControllerDelegate Methods

#pragma mark - HXAlbumsNavigationBarDelegate Methods
- (void)navigationBar:(HXAlbumsNavigationBar *)bar takeAction:(HXAlbumsNavigationBarAction)action {
    switch (action) {
        case HXAlbumsNavigationBarActionBack: {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
    }
}

@end
