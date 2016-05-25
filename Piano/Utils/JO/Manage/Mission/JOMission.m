//
//  JOMission.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/23.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOMission.h"

@implementation JOMission

- (void)startMissionWithConfig:(JOConfig *)config{}

- (void)startMission{}

- (void)cancelMission{

    self.missionSuccessHandler = nil;
    self.missionFailedHandler = nil;
}

- (void)missionSuccessHandler:(MissionSuccessHandler)successHandler{

    self.missionSuccessHandler = nil;
    self.missionSuccessHandler = successHandler;
}

- (void)missionFailedHandler:(MissionFailedHandler)failedHandler{

    self.missionFailedHandler = nil;
    self.missionFailedHandler = failedHandler;
}

@end
