//
//  MIAReportManage.h
//  Piano
//
//  Created by 刘维 on 16/6/8.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ReportState){

    ReportSuccess,//举报成功.
    ReportFaild, //举报取消
    ReportCancel, //举报取消.
};

/**
 *  举报的结果状态.
 *
 *  @param reportState YES:举报成功 NO:举报失败
 */
typedef void(^ReportStateBlock)(ReportState reportState);

@interface MIAReportManage : NSObject

/**
 *  MIAReportManage的单例对象.
 *
 *  @return MIAReportManage对象
 */
+ (instancetype)reportManage;

- (void)reportWithType:(NSString *)type content:(NSString *)content reportHandler:(ReportStateBlock)block;

//- (void)reportWithType:(NSString *)type content:(NSString *)content viewController:(UIViewController *)controller reportHandler:(ReportStateBlock)block;

@end
