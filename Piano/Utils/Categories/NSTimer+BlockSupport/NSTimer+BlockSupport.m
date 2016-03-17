//
//  NSTimer+BlockSupport.m
//
//  Created by linyehui on 2015-10-16.
//
//

#import "NSTimer+BlockSupport.h"

@implementation NSTimer (BlockSupport)

+ (NSTimer *)bs_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
										 block:(void(^)())block
									   repeats:(BOOL)repeats
{
	return [self scheduledTimerWithTimeInterval:interval
										 target:self
									   selector:@selector(bs_blockInvoke:)
									   userInfo:[block copy]
										repeats:repeats];
}

+ (void)bs_blockInvoke:(NSTimer *)timer {
	void (^block)() = timer.userInfo;
	if(block) {
		block();
	}
}

@end