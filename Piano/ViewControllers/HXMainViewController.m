//
//  HXMainViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXLiveViewController.h"
#import "HXReplayViewController.h"
#import "HXPublishViewController.h"
#import "HXSettingViewController.h"

@interface HXMainViewController ()

@end

@implementation HXMainViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Config Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    [self subControllersConfigure];
}

- (void)subControllersConfigure {
//    for (UINavigationController *navigationController in self.viewControllers) {
//        if ([navigationController.restorationIdentifier isEqualToString:[HXDiscoveryViewController navigationControllerIdentifier]]) {
//            [navigationController setViewControllers:@[[HXDiscoveryViewController instance]]];
//        } else if ([navigationController.restorationIdentifier isEqualToString:[HXFavoriteViewController navigationControllerIdentifier]]) {
//            [navigationController setViewControllers:@[[HXFavoriteViewController instance]]];
//        } else if ([navigationController.restorationIdentifier isEqualToString:[HXMeViewController navigationControllerIdentifier]]) {
//            [navigationController setViewControllers:@[[HXMeViewController instance]]];
//        }
//    }
}

@end
