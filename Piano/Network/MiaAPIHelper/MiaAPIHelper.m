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

NSString *const MobileErrorPrompt       = @"手机号码不符合规范，请重新输入";


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

+ (void)guestLoginWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
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

+ (void)thirdLoginWithOpenID:(NSString *)openID
					 unionID:(NSString *)unionID
					   token:(NSString *)token
					nickName:(NSString *)nickName
						 sex:(NSString *)sex
						type:(NSString *)type
					  avatar:(NSString *)avatar
			   completeBlock:(MiaRequestCompleteBlock)completeBlock
				timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = @{}.mutableCopy;
	[dictValues setValue:openID forKey:MiaAPIKey_OpenID];
	[dictValues setValue:unionID forKey:MiaAPIKey_UnionID];
	[dictValues setValue:token forKey:MiaAPIKey_Token];
	[dictValues setValue:nickName forKey:MiaAPIKey_NickName];
	[dictValues setValue:sex forKey:MiaAPIKey_Sex];
	[dictValues setValue:type forKey:MiaAPIKey_From];
	[dictValues setValue:avatar forKey:MiaAPIKey_HeadImageURL];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostThirdLogin
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)loginWithMobile:(NSString *)mobile
           passwordHash:(NSString *)passwordHash
          completeBlock:(MiaRequestCompleteBlock)completeBlock
           timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:mobile forKey:MiaAPIKey_PhoneNumber];
	[dictValues setValue:[NSNumber numberWithLong:1] forKey:MiaAPIKey_Dev];
	[dictValues setValue:MiaAPIDefaultIMEI forKey:MiaAPIKey_IMEI];
	[dictValues setValue:passwordHash forKey:MiaAPIKey_Pwd];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostLogin
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)loginWithSession:(NSString *)uID
				   token:(NSString *)token
		   completeBlock:(MiaRequestCompleteBlock)completeBlock
			timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];
	[dictValues setValue:token forKey:MiaAPIKey_Token];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostSession
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)logoutWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
				   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostLogout
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getVerificationCodeWithType:(long)type
						phoneNumber:(NSString *)phoneNumber
					  completeBlock:(MiaRequestCompleteBlock)completeBlock
					   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:[NSNumber numberWithLong:type] forKey:MiaAPIKey_Type];
	[dictValues setValue:phoneNumber forKey:MiaAPIKey_PhoneNumber];
	[dictValues setValue:MiaAPIDefaultIMEI forKey:MiaAPIKey_IMEI];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostPauth
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)registerWithPhoneNum:(NSString *)phoneNumber
					   scode:(NSString *)scode
					nickName:(NSString *)nickName
				passwordHash:(NSString *)passwordHash
			   completeBlock:(MiaRequestCompleteBlock)completeBlock
				timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:phoneNumber forKey:MiaAPIKey_PhoneNumber];
	[dictValues setValue:scode forKey:MiaAPIKey_SCode];
	[dictValues setValue:nickName forKey:MiaAPIKey_Nick];
	[dictValues setValue:passwordHash forKey:MiaAPIKey_Password];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostRegister
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)resetPasswordWithPhoneNum:(NSString *)phoneNumber
					 passwordHash:(NSString *)passwordHash
							scode:(NSString *)scode
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:phoneNumber forKey:MiaAPIKey_PhoneNumber];
	[dictValues setValue:[NSNumber numberWithLong:1] forKey:MiaAPIKey_Type];
	[dictValues setValue:scode forKey:MiaAPIKey_OldPwd];
	[dictValues setValue:passwordHash forKey:MiaAPIKey_NewPwd];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostChangePwd
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)changePasswordWithOldPasswordHash:(NSString *)oldPasswordHash
						  newPasswordHash:(NSString *)newPasswordHash
							completeBlock:(MiaRequestCompleteBlock)completeBlock
							 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:[NSNumber numberWithLong:0] forKey:MiaAPIKey_Type];
	[dictValues setValue:oldPasswordHash forKey:MiaAPIKey_OldPwd];
	[dictValues setValue:newPasswordHash forKey:MiaAPIKey_NewPwd];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostChangePwd
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)changeNickName:(NSString *)nick
		 completeBlock:(MiaRequestCompleteBlock)completeBlock
		  timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:nick forKey:MiaAPIKey_Nick];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostCnick
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)changeGender:(long)gender
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
		timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:[NSNumber numberWithLong:gender] forKey:MiaAPIKey_Gender];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostGender
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

#pragma mark - Live

+ (void)getRoomListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
				   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Room_GetList
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getHomeListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
						timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Channel_GetHome
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)EnterRoom:(NSString *)roomID
		 completeBlock:(MiaRequestCompleteBlock)completeBlock
		  timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_EnterRoom
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)LeaveRoom:(NSString *)roomID
	completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_LeaveRoom
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)commentRoom:(NSString *)roomID
			content:(NSString *)content
	completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
	[dictValues setValue:content forKey:MiaAPIKey_Content];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_CommentRoom
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}
@end
