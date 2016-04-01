//
//  HXProfileViewController.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXProfileViewController.h"
#import "HXProfileNavigationBar.h"
#import "HXProfileContainerViewController.h"


@interface HXProfileViewController () <
HXProfileNavigationBarDelegate,
HXProfileContainerViewControllerDelegate
>
@end


@implementation HXProfileViewController {
    HXProfileContainerViewController *_containerViewController;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameProfile;
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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

#pragma mark - HXProfileNavigationBarDelegate Methods
- (void)navigationBar:(HXProfileNavigationBar *)bar action:(HXProfileNavigationBarAction)action {
    switch (action) {
        case HXProfileNavigationBarActionBack: {
            [self.navigationController popViewControllerAnimated:YES];
            break;
        }
    }
}

#pragma mark - HXProfileContainerViewControllerDelegate Methods
- (void)container:(HXProfileContainerViewController *)container scrollOffset:(CGFloat)offset {
    [_navigationBar showBottomLine:((offset > 0) ? YES : NO)];
}

@end
