//
//  HXReplayLandscapeViewController.m
//  Piano
//
//  Created by miaios on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayLandscapeViewController.h"


@interface HXReplayLandscapeViewController ()
@end


@implementation HXReplayLandscapeViewController

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
