//
//  NSObject+BlockSupport.m
//
//  Created by linyehui on 2015-10-16.
//
//

#import "NSObject+BlockSupport.h"

@implementation NSObject (BlockSupport)

- (void)bs_performBlock:(void (^)(void))block
		  afterDelay:(NSTimeInterval)delay {
	block = [block copy];
	[self performSelector:@selector(fireBlockAfterDelay:)
			   withObject:block
			   afterDelay:delay];
}

- (void)fireBlockAfterDelay:(void (^)(void))block {
	block();
}

@end