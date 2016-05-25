//
//  JOMission.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/23.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOMacro.h"
#import "JOFException.h"

@class JOConfig;

/**
 *  任务成功执行完的Block.
 *
 *  @param successObject MissionSuccessBlock.
 */
typedef void(^MissionSuccessHandler) (id successObject);

/**
 *  任务执行失败的Block
 *
 *  @param failedObject MissionFailedBlock.
 */
typedef void(^MissionFailedHandler)  (id failedObject);

@protocol Mission
@end

@interface JOMission : NSObject<Mission>

@property (nonatomic, copy) NSString *missionDescription;
@property (nonatomic, copy) MissionSuccessHandler missionSuccessHandler;
@property (nonatomic, copy) MissionFailedHandler missionFailedHandler;
@property (nonatomic, strong) JOConfig *missionConfig;
@property (nonatomic, strong) id target;

/**
 *  使用该方法开始一个任务,传入一个任务的配置类.
 *
 *  @param config 任务的配置类.
 */
- (void)startMissionWithConfig:(JOConfig *)config;

/**
 *  取消一个任务. PS:该方法只会去掉Block的回调,如果有其他特殊的操作需要处理,请自行重载实现该功能.
 */
- (void)cancelMission;

/**
 *  任务完成的Handler.
 *
 *  @param successHandler MissionSuccessBlock.
 */
- (void)missionSuccessHandler:(MissionSuccessHandler)successHandler;

/**
 *  任务失败的Handler.
 *
 *  @param failedHandler MissionFailedBlock.
 */
- (void)missionFailedHandler:(MissionFailedHandler)failedHandler;

@end
