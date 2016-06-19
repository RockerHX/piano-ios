//
//  HXReplayLandscapeViewController.m
//  Piano
//
//  Created by miaios on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXReplayLandscapeViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface HXReplayLandscapeViewController ()
@end


@implementation HXReplayLandscapeViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    for (CALayer *layer in self.replayView.layer.sublayers) {
        if ([layer isKindOfClass:[AVPlayerLayer class]]) {
            layer.frame = self.view.bounds;
            break;
        }
    }
}

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
