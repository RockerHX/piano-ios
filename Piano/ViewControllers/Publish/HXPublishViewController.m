//
//  HXPublishViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPublishViewController.h"

@interface HXPublishViewController ()

@end

@implementation HXPublishViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNamePublish;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXPublishNavigationController";
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
