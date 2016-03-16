//
//  HXSettingViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXSettingViewController.h"

@interface HXSettingViewController ()

@end

@implementation HXSettingViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXSettingNavigationController";
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
