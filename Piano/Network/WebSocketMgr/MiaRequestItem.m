//
//  MiaRequestItem.m
//  mia
//
//  Created by linyehui on 2015/10/16.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import "MiaRequestItem.h"
#import "MiaAPIMacro.h"

@implementation MiaRequestItem

- (instancetype)initWithTimeStamp:(long)timestamp
						  command:(NSString *)command
					  jsonString:(NSString *)jsonString
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	if (self = [super init]) {
		_timestamp = timestamp;
		_command = [command copy];
		_jsonString = [jsonString copy];
		_completeBlock = [completeBlock copy];
		_timeoutBlock = [timeoutBlock copy];
	}

	return self;
}

- (instancetype)initWithCommand:(NSString *)command
					   parameters:(NSDictionary *)parameters
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	if (self = [super init]) {
		_timestamp = [self genTimestamp];
		_command = [command copy];
		_completeBlock = [completeBlock copy];
		_timeoutBlock = [timeoutBlock copy];

		NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
		[dictionary setValue:command forKey:MiaAPIKey_ClientCommand];
		[dictionary setValue:MiaAPIProtocolVersion forKey:MiaAPIKey_Version];
		[dictionary setValue:[NSString stringWithFormat:@"%ld", _timestamp] forKey:MiaAPIKey_Timestamp];

		[dictionary setValue:parameters forKey:MiaAPIKey_Values];

		NSError *error = nil;
		NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
														   options:NSJSONWritingPrettyPrinted
															 error:&error];
		if (error) {
			NSLog(@"conver to json error: dic->%@", error);
		} else {
			NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
			//NSLog(@"%@", jsonString);
			_jsonString = [jsonString copy];
		}
	}

	return self;
}

- (instancetype)copyWithZone:(nullable NSZone *)zone {
	MiaRequestItem *copyItem = [[[self class] allocWithZone:zone] initWithTimeStamp:_timestamp
																			command:_command
																		 jsonString:_jsonString
																	  completeBlock:_completeBlock
																	   timeoutBlock:_timeoutBlock];
	return copyItem;
}

#pragma mark - Private Methods
- (long)genTimestamp {
	long timestamp = (long)([[NSDate date] timeIntervalSince1970] * 1000000);
	long offset = (arc4random() % 1000);
	timestamp = (timestamp + offset);

	return timestamp;
}

@end
