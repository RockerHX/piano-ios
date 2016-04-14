//
//  HXMainViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXDiscoveryViewController.h"
#import "HXPublishViewController.h"
#import "HXMeViewController.h"
#import "HXLoginViewController.h"
#import "HXRecordLiveViewController.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "ReactiveCocoa.h"
#import "HXUserSession.h"
#import "FileLog.h"
#import "UIView+Frame.h"
#import "HXWatchLiveViewController.h"

@interface HXMainViewController () <
UITabBarControllerDelegate,
HXLoginViewControllerDelegate
>
@end

@implementation HXMainViewController {
    UINavigationController *_publishNavigationController;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self tabBarItemConfigure];
}

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
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLogoutNotification object:nil];
}

#pragma mark - Config Methods
- (void)loadConfigure {
    self.delegate = self;
    [[WebSocketMgr standard] watchNetworkStatus];
    
    // Socket
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidOpen:) name:WebSocketMgrNotificationDidOpen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidFailWithError:) name:WebSocketMgrNotificationDidFailWithError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidAutoReconnectFailed:) name:WebSocketMgrNotificationDidAutoReconnectFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidCloseWithCode:) name:WebSocketMgrNotificationDidCloseWithCode object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldShowLoginSence) name:kLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutCompleted) name:kLogoutNotification object:nil];
}

- (void)viewConfigure {
    self.view.backgroundColor = [UIColor whiteColor];
    [self subControllersConfigure];
}

- (void)subControllersConfigure {
    for (UINavigationController *navigationController in self.viewControllers) {
        if ([navigationController.restorationIdentifier isEqualToString:[HXDiscoveryViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXDiscoveryViewController instance]]];
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXMeViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXMeViewController instance]]];
        }
    }
    
    NSArray *viewControllers = self.viewControllers;
    _publishNavigationController = viewControllers[1];
    if ([HXUserSession session].role == HXUserRoleAnchor) {
        return;
    }
    self.viewControllers = @[[viewControllers firstObject], [viewControllers lastObject]];
}

- (void)tabBarItemConfigure {
    for (UITabBarItem *item in self.tabBar.items) {
        item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
}

#pragma mark - Public Methods
- (void)watchLiveWithRoomID:(NSString *)roomID {
    UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
    HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
    watchLiveViewController.roomID = roomID;
    [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
}

#pragma mark - Private Methods
- (void)shouldShowLoginSence {
    HXLoginViewController *loginViewController = [self showLoginSence];
    loginViewController.delegate = self;
}

- (void)logoutCompleted {
    self.viewControllers = @[[self.viewControllers firstObject], [self.viewControllers lastObject]];
    [self setSelectedIndex:0];
}

#pragma mark - Socket
- (void)notificationWebSocketDidOpen:(NSNotification *)notification {
	[MiaAPIHelper guestLoginWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
		if (success) {
            HXUserSession *userSession = [HXUserSession session];
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
			HXGuestModel *user = [HXGuestModel mj_objectWithKeyValues:data];
			[userSession updateGuest:user];

//			[self checkUpdate];
			[self autoLogin];

			UINavigationController *discoveryNavigationController = self.viewControllers.firstObject;
			HXDiscoveryViewController *discoveryViewController = discoveryNavigationController.viewControllers.firstObject;
			[discoveryViewController startFetchList];
		} else {
			[self autoReconnect];
		}
	} timeoutBlock:^(MiaRequestItem *requestItem) {
		[self autoReconnect];
	}];
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

- (void)autoLogin {
	HXUserSession *userSession = [HXUserSession session];
    switch (userSession.state) {
        case HXUserStateLogout: {
            return;
            break;
        }
        case HXUserStateLogin: {
            [MiaAPIHelper loginWithSession:userSession.uid
                                     token:userSession.token
                             completeBlock:
             ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                 if (success) {
                     NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
                     HXUserModel *user = [HXUserModel mj_objectWithKeyValues:data];
                     [userSession updateUser:user];
                     
                     [self fetchProfileData];
//                     [self updateNotificationBadge];
                 } else {
                     [[FileLog standard] log:@"autoLogin failed, logout"];
                     [userSession logout];
                 }
             } timeoutBlock:^(MiaRequestItem *requestItem) {
                 NSLog(@"audo login timeout!");
             }];
            break;
        }
    }
}

- (void)autoReconnect {
	[[WebSocketMgr standard] reconnect];
}

- (void)fetchProfileData {
    HXMeViewController *meViewController = [((UINavigationController *)[self.viewControllers lastObject]).viewControllers firstObject];
    [meViewController refresh];
}

- (void)startLive {
    UINavigationController *recordLiveNavigationController = [HXRecordLiveViewController navigationControllerInstance];
//    HXRecordLiveViewController *recordLiveViewController = recordLiveNavigationController.viewControllers.firstObject;
    [self presentViewController:recordLiveNavigationController animated:YES completion:nil];
}

#pragma mark - UITabBarControllerDelegate Methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([[self.viewControllers firstObject] isEqual:viewController]) {
        return YES;
    }
    
    switch ([HXUserSession session].state) {
        case HXUserStateLogout: {
            [self shouldShowLoginSence];
            return NO;
            break;
        }
        case HXUserStateLogin: {
            if ([[self.viewControllers lastObject] isEqual:viewController]) {
                return YES;
            } else {
                [self startLive];
                return NO;
            }
        }
    }
}

#pragma mark - HXLoginViewControllerDelegate Methods
- (void)loginViewController:(HXLoginViewController *)loginViewController takeAction:(HXLoginViewControllerAction)action {
    switch (action) {
        case HXLoginViewControllerActionDismiss: {
            break;
        }
        case HXLoginViewControllerActionLoginSuccess: {
            if ([HXUserSession session].role == HXUserRoleAnchor) {
                self.viewControllers = @[[self.viewControllers firstObject], _publishNavigationController, [self.viewControllers lastObject]];
            }
            [self fetchProfileData];
            break;
        }
    }
}

@end
