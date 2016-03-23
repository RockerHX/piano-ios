//
//  HXPanGestureNavgaitionController.m
//  mia
//
//  Created by miaios on 15/11/2.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXPanGestureNavgaitionController.h"

@interface HXPanGestureNavgaitionController () <UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@end

@implementation HXPanGestureNavgaitionController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Config Methods
- (void)loadConfigure {
    self.delegate = self;
    self.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewConfigure {
    ;
}

#pragma mark - UIGestureRecognizerDelegate Methods
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

#pragma mark - Navigation Controller Delegate Methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger viewControllersCount = navigationController.viewControllers.count;
    if (viewControllersCount > 1) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, 26.0f, 26.0f);
        button.imageEdgeInsets = UIEdgeInsetsMake(0.0f, -16.0f, 0.0f, 0.0f);
        [button setImage:[UIImage imageNamed:@"C-BackIcon-Gray"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
}

#pragma mark - Private Methods
- (void)backButtonPressed {
    [self popViewControllerAnimated:YES];
}

@end
