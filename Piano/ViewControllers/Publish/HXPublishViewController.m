//
//  HXPublishViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPublishViewController.h"
#import <ZegoAVKit/ZegoAVConfig.h>
#import "HXZegoAVKitManager.h"
#import "HXMainViewController.h"


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

#pragma mark - Event Response
- (IBAction)previewSwitchChanged:(UISwitch *)sender {
    if (sender.on) {
        [self startPreview];
    } else {
        [self stopPreview];
    }
}

- (IBAction)frontCameraSwitchChanged:(UISwitch *)sender {
    [[HXZegoAVKitManager manager].zegoAVApi setFrontCam:sender.on];
}

- (IBAction)liveSwitchChanged:(UISwitch *)sender {
    if (sender.on) {
        [self stopPreview];
        [self startLive];
    }
    sender.on = NO;
}

#pragma mark - Private Methods
- (void)startPreview {
    ZegoAVConfig *zegoAVConfig = [ZegoAVConfig defaultZegoAVConfig:ZegoAVConfigPreset_Generic];
    
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
//    SetConfigReturnType config = [zegoAVApi setAVConfig:zegoAVConfig];
//    bool localView = [zegoAVApi setLocalView:self.view];
//    bool startPreview = [zegoAVApi startPreview];
    
    [zegoAVApi setAVConfig:zegoAVConfig];
    [zegoAVApi setLocalView:self.view];
    [zegoAVApi startPreview];
}

- (void)stopPreview {
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    [zegoAVApi setLocalView:nil];
    [zegoAVApi stopPreview];
}

- (void)startLive {
    HXLiveModel *model = [HXLiveModel new];
    [(HXMainViewController *)self.tabBarController showLiveWithModel:model type:HXLiveTypePublish];
}

@end
