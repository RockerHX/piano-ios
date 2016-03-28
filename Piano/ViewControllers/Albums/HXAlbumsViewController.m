//
//  HXAlbumsViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXAlbumsViewController.h"
#import "HXAlbumsContainerViewController.h"


@interface HXAlbumsViewController () <
HXAlbumsContainerViewControllerDelegate
>
@end


@implementation HXAlbumsViewController {
    HXAlbumsContainerViewController *_containerViewController;
}

#pragma mark - Class Methods
+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameAlbums;
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXAlbumsNavigationController";
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
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

#pragma mark - HXAlbumsContainerViewControllerDelegate Methods

@end
