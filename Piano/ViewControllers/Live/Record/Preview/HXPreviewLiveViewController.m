//
//  HXPreviewLiveViewController.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPreviewLiveViewController.h"
#import "HXCountDownViewController.h"
#import "HXZegoAVKitManager.h"
#import "HXSettingSession.h"
#import "HXPreviewLiveTopBar.h"


@interface HXPreviewLiveViewController () <
HXPreviewLiveTopBarDelegate
>
@end


@implementation HXPreviewLiveViewController {
    HXCountDownViewController *_countDownViewController;
    
    BOOL _frontCamera;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _countDownViewController = segue.destinationViewController;
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _frontCamera = YES;
}

- (void)viewConfigure {
    [self startPreview];
}

#pragma mark - Private Methods
- (void)startPreview {
    [[HXZegoAVKitManager manager].zegoAVApi setFrontCam:_frontCamera];
    
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    [zegoAVApi setAVConfig:[HXSettingSession session].configure];
    [zegoAVApi setLocalView:_preview];
    [zegoAVApi setLocalViewMode:ZegoVideoViewModeScaleAspectFill];
    [zegoAVApi startPreview];
}

- (void)stopPreview {
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    [zegoAVApi setLocalView:nil];
    [zegoAVApi stopPreview];
}

#pragma mark - HXPreviewLiveTopBarDelegate Methods
- (void)topBar:(HXPreviewLiveTopBar *)bar takeAction:(HXPreviewLiveTopBarAction)action {
    switch (action) {
        case HXPreviewLiveTopBarActionBeauty: {
            ;
            break;
        }
        case HXPreviewLiveTopBarActionChange: {
            _frontCamera = !_frontCamera;
            [[HXZegoAVKitManager manager].zegoAVApi setFrontCam:_frontCamera];
            break;
        }
        case HXPreviewLiveTopBarActionColse: {
            [self dismissViewControllerAnimated:YES completion:nil];
            break;
        }
    }
}

@end
