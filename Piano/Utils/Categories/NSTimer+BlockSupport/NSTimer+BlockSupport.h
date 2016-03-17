//
//  NSTimer+BlockSupport.h
//
//  Created by linyehui on 2015-10-16.
//
//

#import <Foundation/Foundation.h>

@interface NSTimer (BlockSupport)

+ (NSTimer *)bs_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
										 block:(void(^)())block
									   repeats:(BOOL)repeats;

@end

