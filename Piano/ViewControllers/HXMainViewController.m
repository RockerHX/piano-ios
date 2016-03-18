//
//  HXMainViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXOnlineViewController.h"
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
    for (UINavigationController *navigationController in self.viewControllers) {
        if ([navigationController.restorationIdentifier isEqualToString:[HXOnlineViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXOnlineViewController instance]]];
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXReplayViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXReplayViewController instance]]];
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXPublishViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXPublishViewController instance]]];
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXSettingViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXSettingViewController instance]]];
        }
    }
}

@end
