//
//  HXMainViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXOnlineViewController.h"
#import "HXPublishViewController.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "HXMeViewController.h"
#import "ReactiveCocoa.h"


@interface HXMainViewController () <
UITabBarControllerDelegate
>
@end

@implementation HXMainViewController {
    
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
    
    
}

- (void)dealloc {
    // Socket
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WebSocketMgrNotificationDidOpen object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WebSocketMgrNotificationDidFailWithError object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WebSocketMgrNotificationDidAutoReconnectFailed object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:WebSocketMgrNotificationDidCloseWithCode object:nil];
}

#pragma mark - Config Methods
- (void)loadConfigure {
    [[WebSocketMgr standard] watchNetworkStatus];
    
    // Socket
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidOpen:) name:WebSocketMgrNotificationDidOpen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidFailWithError:) name:WebSocketMgrNotificationDidFailWithError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidAutoReconnectFailed:) name:WebSocketMgrNotificationDidAutoReconnectFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidCloseWithCode:) name:WebSocketMgrNotificationDidCloseWithCode object:nil];
}

- (void)viewConfigure {
    [self subControllersConfigure];
}

- (void)subControllersConfigure {
    for (UINavigationController *navigationController in self.viewControllers) {
        if ([navigationController.restorationIdentifier isEqualToString:[HXOnlineViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXOnlineViewController instance]]];
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXPublishViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXPublishViewController instance]]];
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXMeViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXMeViewController instance]]];
        }
    }
}

#pragma mark - Public Methods
- (void)showLiveWithModel:(HXLiveModel *)model type:(HXLiveType)type {
    if (model) {
        HXLiveViewController *liveViewController = [HXLiveViewController instance];
        liveViewController.model = model;
        liveViewController.type = type;
        [self presentViewController:liveViewController animated:YES completion:nil];
    }
}

#pragma mark - Socket
- (void)notificationWebSocketDidOpen:(NSNotification *)notification {
    UINavigationController *onlineNavigationController = self.viewControllers.firstObject;
    HXOnlineViewController *onlineViewController = onlineNavigationController.viewControllers.firstObject;
    [onlineViewController startFetchOnlineList];
}

- (void)notificationWebSocketDidFailWithError:(NSNotification *)notification {
    NSLog(@"notificationWebSocketDidFailWithError");
}

- (void)notificationWebSocketDidAutoReconnectFailed:(NSNotification *)notification {
    NSLog(@"notificationWebSocketDidAutoReconnectFailed");
}

- (void)notificationWebSocketDidCloseWithCode:(NSNotification *)notification {
    NSLog(@"Connection Closed! (see logs)");
}

#pragma mark - UITabBarControllerDelegate Methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}

@end
