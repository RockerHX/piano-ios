//
//  JOManage.m
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/23.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import "JOManage.h"

@interface JOManage()

//@property (nonatomic, strong) JOConfig *config;
//@property (nonatomic, copy) NSArray *missionArray;
//@property (nonatomic, strong) JOMission *mission;

@end

@implementation JOManage

- (void)startManageWithConfig:(JOConfig *)config{

}

- (void)startManageMission:(JOMission *)mission{

}

- (void)startManageMissionArray:(NSArray *)missionArray{
    
}

- (void)cancelAllMission{

//    if (self.mission) {
//        [_mission cancelMission];
//    }
//    
//    if (self.missionArray && [_missionArray count]) {
//        
//        for (id mission in _missionArray) {
//            
//            if ([mission isKindOfClass:[JOMission class]]) {
//                [(JOMission *)mission cancelMission];
//            }
//        }
//    }
//    
//    self.missionCompleteBlock = nil;
//    self.missionInterruptBlock = nil;
}

- (void)manageMissionCompleteHandler:(MissionCompleteHandler)completeHandler{

    self.missionCompleteHandler = nil;
    self.missionCompleteHandler = completeHandler;
}

- (void)manageMissionInterruptHandler:(MissionInterruptHandler)interrupHandler{
    
    self.missionInterruptHandler = nil;
    self.missionInterruptHandler = interrupHandler;
}

@end
