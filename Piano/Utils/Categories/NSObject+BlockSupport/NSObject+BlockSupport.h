//
//  NSObject+BlockSupport.h
//
//  Created by linyehui on 2015-10-16.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (BlockSupport)

- (void)bs_performBlock:(void (^)(void))block
		  afterDelay:(NSTimeInterval)delay;

@end
