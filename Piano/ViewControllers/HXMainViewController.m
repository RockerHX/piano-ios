//
//  HXMainViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMainViewController.h"
#import "HXDiscoveryViewController.h"
#import "HXLoginViewController.h"
#import "HXWatchLiveViewController.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "HXUserSession.h"
#import "FileLog.h"
#import "UIView+Frame.h"
#import "HXGiftManager.h"
#import "HXNoNetworkView.h"


@interface HXMainViewController () <
HXDiscoveryViewControllerDelegate,
HXLoginViewControllerDelegate
>
@end

@implementation HXMainViewController {
    BOOL _shouldHiddenNavigationBar;
    
    HXDiscoveryViewController *_discoveryContainerViewController;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:NSStringFromClass([HXDiscoveryViewController class])]) {
        _discoveryContainerViewController = segue.destinationViewController;
        _discoveryContainerViewController.delegate = self;
    }
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:_shouldHiddenNavigationBar animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        switch ([HXUserSession session].state) {
            case HXUserStateLogout: {
                [self shouldShowLoginSenceWithAnimation:NO];
                break;
            }
            case HXUserStateLogin: {
                [self autoLogin];
                break;
            }
        }
    });
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
    [[WebSocketMgr standard] watchNetworkStatus];
    
    // Socket
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidOpen:) name:WebSocketMgrNotificationDidOpen object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidFailWithError:) name:WebSocketMgrNotificationDidFailWithError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidAutoReconnectFailed:) name:WebSocketMgrNotificationDidAutoReconnectFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationWebSocketDidCloseWithCode:) name:WebSocketMgrNotificationDidCloseWithCode object:nil];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shouldShowLoginSence) name:kLoginNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutCompleted) name:kLogoutNotification object:nil];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)watchLiveWithRoomID:(NSString *)roomID {
    if (roomID.length) {
        UINavigationController *watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
        HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];
        watchLiveViewController.roomID = roomID;
        [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
    }
}

#pragma mark - Private Methods
- (void)shouldShowLoginSenceWithAnimation:(BOOL)animation {
    UINavigationController *loginNavigationController = [HXLoginViewController navigationControllerInstance];
    HXLoginViewController *loginViewController = loginNavigationController.viewControllers.firstObject;
    loginViewController.delegate = self;
    [self presentViewController:loginNavigationController animated:animation completion:nil];
}

- (void)logoutCompleted {
    [self shouldShowLoginSenceWithAnimation:YES];
}

#pragma mark - Socket
- (void)notificationWebSocketDidOpen:(NSNotification *)notification {
    [HXGiftManager manager];
	[MiaAPIHelper guestLoginWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
		if (success) {
            HXUserSession *userSession = [HXUserSession session];
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
			HXGuestModel *user = [HXGuestModel mj_objectWithKeyValues:data];
			[userSession updateGuest:user];

//			[self checkUpdate];
			[self autoLogin];
            
            [_discoveryContainerViewController startFetchList];
            [HXNoNetworkView hidden];
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
    [self showNoNetworkView];
}

- (void)notificationWebSocketDidCloseWithCode:(NSNotification *)notification {
    NSLog(@"Connection Closed! (see logs)");
}

- (void)showNoNetworkView {
    [HXNoNetworkView showOnViewController:self.navigationController show:nil play:nil];
}

- (void)autoLogin {
    HXUserSession *userSession = [HXUserSession session];
    [MiaAPIHelper loginWithSession:userSession.uid
                             token:userSession.token
                     completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         if (success) {
             NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
             HXUserModel *user = [HXUserModel mj_objectWithKeyValues:data];
             [userSession updateUser:user];
             
             //                     [self updateNotificationBadge];
         } else {
             [[FileLog standard] log:@"autoLogin failed, logout"];
             [userSession logout];
         }
     } timeoutBlock:^(MiaRequestItem *requestItem) {
         NSLog(@"audo login timeout!");
     }];
}

- (void)autoReconnect {
	[[WebSocketMgr standard] reconnect];
}

#pragma mark - HXDiscoveryViewControllerDelegate
- (void)discoveryViewController:(HXDiscoveryViewController *)viewController takeAction:(HXDiscoveryViewControllerAction)action {
    switch (action) {
        case HXDiscoveryViewControllerActionHiddenNavigationBar: {
            _shouldHiddenNavigationBar = YES;
            break;
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
            [_discoveryContainerViewController startFetchList];
            break;
        }
    }
}

@end
