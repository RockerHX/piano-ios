//
//  HXLiveRewardLandscapeViewController.m
//  Piano
//
//  Created by miaios on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveRewardLandscapeViewController.h"


@interface HXLiveRewardLandscapeViewController ()
@end


@implementation HXLiveRewardLandscapeViewController

#pragma mark - Orientations Methods
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

@end
