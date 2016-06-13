//
//  HXLiveGiftLandscapeViewController.m
//  Piano
//
//  Created by miaios on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveGiftLandscapeViewController.h"


@interface HXLiveGiftLandscapeViewController ()
@end


@implementation HXLiveGiftLandscapeViewController

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
