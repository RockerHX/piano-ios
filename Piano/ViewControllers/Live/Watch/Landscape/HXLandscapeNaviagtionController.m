//
//  HXLandscapeNaviagtionController.m
//  Piano
//
//  Created by miaios on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLandscapeNaviagtionController.h"


@interface HXLandscapeNaviagtionController ()
@end


@implementation HXLandscapeNaviagtionController

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
