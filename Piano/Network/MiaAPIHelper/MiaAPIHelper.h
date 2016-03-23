//
//  MiaAPIHelper.h
//  mia
//
//  Created by linyehui on 2016/03/17.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiaAPIMacro.h"
#import "MiaRequestItem.h"


FOUNDATION_EXPORT NSString *const TimtOutPrompt;            // 请求超时提示
FOUNDATION_EXPORT NSString *const DataParseErrorPrompt;     // 数据解析出错提示
FOUNDATION_EXPORT NSString *const UnknowErrorPrompt;        // 未知错误提示
FOUNDATION_EXPORT NSString *const MobileErrorPrompt;        // 手机号码错误提示



@interface MiaAPIHelper : NSObject

+ (id)getUUID;
+ (void)sendUUIDWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getRoomListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
						timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

@end
