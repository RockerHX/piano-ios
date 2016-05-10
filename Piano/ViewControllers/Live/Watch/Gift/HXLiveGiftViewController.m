//
//  HXLiveGiftViewController.m
//  Piano
//
//  Created by miaios on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXLiveGiftViewController.h"
#import "BlocksKit+UIKit.h"


@interface HXLiveGiftViewController ()
@end


@implementation HXLiveGiftViewController

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameLive;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof__(self)weakSelf = self;
    [self.view bk_whenTapped:^{
        __strong __typeof__(self)strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
