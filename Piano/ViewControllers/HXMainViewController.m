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
#import "HXMeViewController.h"
#import "HXLoginViewController.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "ReactiveCocoa.h"
#import "HXUserSession.h"
#import "FileLog.h"

@interface HXMainViewController () <
UITabBarControllerDelegate,
HXLoginViewControllerDelegate
>
@end

@implementation HXMainViewController {
    UINavigationController *_publishNavigationController;
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
    self.delegate = self;
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
        } else if ([navigationController.restorationIdentifier isEqualToString:[HXMeViewController navigationControllerIdentifier]]) {
            [navigationController setViewControllers:@[[HXMeViewController instance]]];
        }
    }
    
    NSArray *viewControllers = self.viewControllers;
    _publishNavigationController = viewControllers[1];
    self.viewControllers = @[[viewControllers firstObject], [viewControllers lastObject]];
}

#pragma mark - Private Methods
- (void)showLoginSence {
    UINavigationController *loginNavigationController = [HXLoginViewController navigationControllerInstance];
    HXLoginViewController *loginViewController = loginNavigationController.viewControllers.firstObject;
    loginViewController.delegate = self;
    
    __weak __typeof__(self)weakSelf = self;
    [self transitionAnimationWithDuration:0.3f type:kCATransitionMoveIn subtype:kCATransitionFromRight transiteCode:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf presentViewController:loginNavigationController animated:NO completion:nil];
    }];
}

- (void)transitionAnimationWithDuration:(CFTimeInterval)duration type:(NSString *)type subtype:(NSString *)subtype transiteCode:(void(^)(void))transiteCode {
    if (transiteCode) {
        [CATransaction begin];
        
        CATransition *transition = [CATransition animation];
        transition.duration = duration;
        transition.type = type;
        transition.subtype = subtype;
        transition.fillMode = kCAFillModeForwards;
        
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:kCATransition];
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        [CATransaction setCompletionBlock: ^ {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            });
        }];
        
        transiteCode();
        
        [CATransaction commit];
    }
}

#pragma mark - Socket
- (void)notificationWebSocketDidOpen:(NSNotification *)notification {
	[MiaAPIHelper guestLoginWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
		if (success) {
			HXUserSession *userSession = [HXUserSession session];
			NSDictionary *data = userInfo[MiaAPIKey_Values];
			HXGuestModel *user = [HXGuestModel mj_objectWithKeyValues:data];
			[userSession updateGuest:user];

//			[self checkUpdate];
			[self autoLogin];

			UINavigationController *onlineNavigationController = self.viewControllers.firstObject;
			HXOnlineViewController *onlineViewController = onlineNavigationController.viewControllers.firstObject;
			[onlineViewController startFetchList];

#warning @andy
//			[MiaAPIHelper getAlbumWithID:@"1" completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//				NSLog(@"getAlbumWithID");
//			} timeoutBlock:^(MiaRequestItem *requestItem) {
//				NSLog(@"");
//			}];

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
                     NSDictionary *data = userInfo[MiaAPIKey_Values];
                     [userSession updateUserWithData:data];
                     
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

#pragma mark - UITabBarControllerDelegate Methods
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([[self.viewControllers firstObject] isEqual:viewController]) {
        return YES;
    }
    
    switch ([HXUserSession session].state) {
        case HXUserStateLogout: {
            [self showLoginSence];
            return NO;
            break;
        }
        case HXUserStateLogin: {
            if ([[self.viewControllers lastObject] isEqual:viewController]) {
                return YES;
            } else {
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
            [self fetchProfileData];
            break;
        }
    }
    
    [self transitionAnimationWithDuration:0.3f type:kCATransitionReveal subtype:kCATransitionFromLeft transiteCode:^{
        [loginViewController dismissViewControllerAnimated:NO completion:nil];
    }];
}

@end
