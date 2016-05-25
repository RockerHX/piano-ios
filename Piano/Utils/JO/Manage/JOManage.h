//
//  JOManage.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 15/10/23.
//  Copyright © 2015年 刘维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOConfig.h"
#import "JOMission.h"

//@class JOMission;
/**
 *  任务都成功完成的Block.
 *
 *  @param completeObject 返回成功的对象
 *  @param completeTag   完成的tag值, 可以根据它设置不同的完成状态.
 */
typedef void (^MissionCompleteHandler)  (id completeObject, NSInteger completeTag);

/**
 *  任务执行中断的Block. 其中出现了失败的任务
 *
 *  @param interruptObject 返回中断的对象
 *  @param interruptTag   中断的tag值, 可以根据它设置不同的中断的状态.
 */
typedef void (^MissionInterruptHandler) (id interruptObject, NSInteger interruptTag);

@protocol Manage
@end

@interface JOManage : NSObject<Manage>

@property (nonatomic, copy) NSString *manageDescription;

@property (nonatomic, copy) MissionCompleteHandler missionCompleteHandler;
@property (nonatomic, copy) MissionInterruptHandler missionInterruptHandler;

/**
 *  根据配置文件去执行一个任务.
 *  Mission的子类重载实现了startMissionWithConfig方法.
 *
 *  @param config 配置类
 */
- (void)startManageWithConfig:(JOConfig *)config;

/**
 *  根据配置文件去执行一个任务.
 *
 *  @param mission 具体的任务类.
 */
- (void)startManageMission:(JOMission *)mission;

/**
 *  执行一个任务组.
 *
 *  @param missionArray 任务的数组.
 */
- (void)startManageMissionArray:(NSArray *)missionArray DEPRECATED_MSG_ATTRIBUTE("还未想好如何去实现该功能");

/**
 *  取消所有的任务.ps:必须重载该方法自己去实现任务的取消.
 */
- (void)cancelAllMission;

/**
 *  任务执行完成的Handler.
 *
 *  @param completeHandler MissionCompleteBlock.
 */
- (void)manageMissionCompleteHandler:(MissionCompleteHandler)completeHandler;

/**
 *  任务执行中断的Handler.
 *
 *  @param interrupHandler MissionInterruptBlock.
 */
- (void)manageMissionInterruptHandler:(MissionInterruptHandler)interrupHandler;

@end
