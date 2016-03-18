//
//  MiaAPIHelper.h
//  mia
//
//  Created by linyehui on 2016/03/17.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "UserDefaultsUtils.h"
#import "NSString+IsNull.h"


NSString *const TimtOutPrompt           = @"请求超时，请稍后重试";
NSString *const DataParseErrorPrompt    = @"数据解析出错，请联系Mia客服";
NSString *const UnknowErrorPrompt       = @"未知错误，请联系Mia客服";


@interface MiaAPIHelper()

@end

@implementation MiaAPIHelper{
}

+ (id)getUUID {
	static NSString * const UserDefaultsKey_UUID = @"uuid";
	NSString *currentUUID = [UserDefaultsUtils valueWithKey:UserDefaultsKey_UUID];
	if (!currentUUID) {
		currentUUID = [[NSUUID UUID] UUIDString];
		[UserDefaultsUtils saveValue:currentUUID forKey:UserDefaultsKey_UUID];
	}

	return currentUUID;
}

+ (long)genTimestamp {
	long timestamp = (long)([[NSDate date] timeIntervalSince1970] * 1000000);
	long offset = (arc4random() % 1000);
	timestamp = (timestamp + offset);

	return timestamp;
}

+ (void)sendUUIDWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSString *currentUUID = [self getUUID];

	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:currentUUID forKey:MiaAPIKey_GUID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostGuest
														  parameters:dictValues
													   completeBlock:completeBlock
														timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getRoomListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
				   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Room_GetList
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

@end
