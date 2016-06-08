//
//  MIAInfoLog.h
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MIAInfoLog : NSObject

/**
 *  上传一些信息的日志.
 *
 *  @param roomID   房间的id.
 *  @param streamID 流的id.
 */
+ (void)uploadInfoLogWithRoomID:(NSString *)roomID streamID:(NSString *)streamID;

@end
