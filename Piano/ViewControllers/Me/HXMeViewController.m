//
//  HXMeViewController.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeViewController.h"
#import "HXMeNavigationBar.h"
#import "HXMeContainerViewController.h"


@interface HXMeViewController () <
HXMeNavigationBarDelegate,
HXMeContainerViewControllerDelegate
>
@end


@implementation HXMeViewController {
    HXMeContainerViewController *_containerViewController;
    HXMeViewModel *_viewModel;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMe;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXMeNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:_shouldHideNavigationBar animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _containerViewController.viewModel = self.viewModel;
}

- (void)viewConfigure {
    [self showHUD];
}

#pragma mark - Property
- (HXMeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [HXMeViewModel new];
    }
    return _viewModel;
}

#pragma mark - Public Methods
- (void)refresh {
    @weakify(self)
    RACSignal *fetchSignal = [self.viewModel.fetchCommand execute:nil];
    [fetchSignal subscribeError:^(NSError *error) {
        @strongify(self)
        [self showBannerWithPrompt:error.domain];
    } completed:^{
        @strongify(self)
        [self hiddenHUD];
        [self->_containerViewController refresh];
    }];
}

#pragma mark - HXMeNavigationBarDelegate Methods
- (void)navigationBar:(HXMeNavigationBar *)bar action:(HXMeNavigationBarAction)action {
    switch (action) {
        case HXMeNavigationBarActionSetting: {
            ;
            break;
        }
    }
}

#pragma mark - HXMeContainerViewControllerDelegate Methods
- (void)container:(HXMeContainerViewController *)container scrollOffset:(CGFloat)offset {
    [_navigationBar showBottomLine:((offset > 0) ? YES : NO)];
}

@end
