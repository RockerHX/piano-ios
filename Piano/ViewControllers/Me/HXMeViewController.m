//
//  HXMeViewController.m
//  Piano
//
//  Created by miaios on 16/3/22.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeViewController.h"
#import "HXMeNavigationBar.h"


@interface HXMeViewController () <
HXMeNavigationBarDelegate
>
@end


@implementation HXMeViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameMe;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXMeNavigationController";
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    
//    [self.navigationController setNavigationBarHidden:_shouldHideNavigationBar animated:YES];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - HXMeNavigationBarDelegate Methods
- (void)navigationBar:(HXMeNavigationBar *)bar action:(HXMeNavigationBarAction)action {
    ;
}

@end
