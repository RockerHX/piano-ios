//
//  MiaRequestItem.h
//  mia
//
//  Created by linyehui on 2015/10/16.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MiaRequestItem;

typedef void (^MiaRequestCompleteBlock)(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo);
typedef void (^MiaRequestTimeoutBlock)(MiaRequestItem *requestItem);

@interface MiaRequestItem : NSObject <NSCopying>

// 虽然系统的timestamp是double，但double有精度问题，不适合用来做唯一的key
@property (assign, nonatomic) long timestamp;
@property (copy, nonatomic) NSString *command;
@property (copy, nonatomic) NSString *jsonString;
@property (nonatomic, copy) MiaRequestCompleteBlock completeBlock;
@property (nonatomic, copy) MiaRequestTimeoutBlock timeoutBlock;

- (instancetype)initWithTimeStamp:(long)timestamp
						  command:(NSString *)command
					   jsonString:(NSString *)jsonString
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

- (instancetype)initWithCommand:(NSString *)command
					   parameters:(NSDictionary *)parameters
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

@end
