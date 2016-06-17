//
//  MIAProfileNavigationController.m
//  Piano
//
//  Created by 刘维 on 16/6/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileNavigationController.h"

@interface MIAProfileNavigationController ()

@end

@implementation MIAProfileNavigationController

+ (MIAProfileNavigationController *)profileNavigationInstanceWithUID:(NSString *)uid{
    MIAProfileViewController *profileViewController = [MIAProfileViewController new];
    [profileViewController setUid:uid];
    MIAProfileNavigationController *profileNavigationController = [[MIAProfileNavigationController alloc] initWithRootViewController:profileViewController];
    return profileNavigationController;
}

+ (MIAProfileViewController *)profileViewControllerInstanceWithUID:(NSString *)uid{
    MIAProfileViewController *profileViewController = [MIAProfileViewController new];
    [profileViewController setUid:uid];
    return profileViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - interface orientation

- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
    
}

@end
