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

+ (void)getUploadAuthWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
								timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_GetUpload
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)uploadFinishWithFileID:(NSString *)fileID
			completeBlock:(MiaRequestCompleteBlock)completeBlock
			 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:fileID forKey:MiaAPIKey_fileID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostUploadfinish
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)feedbackWithNote:(NSString *)note
				 contact:(NSString *)contact
		   completeBlock:(MiaRequestCompleteBlock)completeBlock
			timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:note forKey:MiaAPIKey_Note];
	if (![NSString isNull:contact]) {
		[dictValues setValue:contact forKey:MiaAPIKey_Contact];
	}

	[dictValues setValue:[UIDevice currentDevice].systemName forKey:MiaAPIKey_Platform];
	[dictValues setValue:[UIDevice currentDevice].systemVersion forKey:MiaAPIKey_OSVersion];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_Feedback
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

#pragma mark - Live
+ (void)getHomeListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
						timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Channel_GetHome
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getMusiciansWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
						timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Channel_GetMusician
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)enterRoom:(NSString *)roomID
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

+ (void)leaveRoom:(NSString *)roomID
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

+ (void)liveGetAlbumListWithUID:(NSString *)UID
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                  completeBlock:(MiaRequestCompleteBlock)completeBlock
                   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:UID forKey:MiaAPIKey_UID];
    [dictValues setValue:@(start) forKey:MiaAPIKey_Start];
    [dictValues setValue:@(limit) forKey:MiaAPIKey_Limit];
    
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_GetAlbumList
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

+ (void)createRoomWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_PostCreate
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)liveRelatedAlbum:(NSString *)albumID
                  roomID:(NSString *)roomID
           completeBlock:(MiaRequestCompleteBlock)completeBlock
            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:albumID forKey:MiaAPIKey_AlbumID];
    [dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
    
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_RelatedAlbum
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)setRoomTitle:(NSString *)title
			  roomID:(NSString *)roomID
	completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
	[dictValues setValue:title forKey:MiaAPIKey_Title];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_PutTitle
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)setRoomCover:(NSString *)coverID
			  roomID:(NSString *)roomID
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
	[dictValues setValue:coverID forKey:MiaAPIKey_CoverID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_PutCover
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)setRoomLocationWithLatitude:(double)lat
							  longitude:(double)lon
								address:(NSString *)address
								 roomID:(NSString *)roomID
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
	[dictValues setValue:address forKey:MiaAPIKey_Address];
	[dictValues setValue:[NSNumber numberWithFloat:lat] forKey:MiaAPIKey_Latitude];
	[dictValues setValue:[NSNumber numberWithFloat:lon] forKey:MiaAPIKey_Longitude];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_PutLocation
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)forbidUser:(NSString *)uID
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_PostForbid
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getFollowStateWithUID:(NSString *)uID
                completeBlock:(MiaRequestCompleteBlock)completeBlock
                 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];
	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_GetFollow
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)followWithUID:(NSString *)uID
		completeBlock:(MiaRequestCompleteBlock)completeBlock
		 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];
	// "type": "1 关注， 2取消关注"
	[dictValues setValue:[NSNumber numberWithLong:1] forKey:MiaAPIKey_Type];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostFollow
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)unfollowWithUID:(NSString *)uID
		completeBlock:(MiaRequestCompleteBlock)completeBlock
		 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];
	// "type": "1 关注， 2取消关注"
	[dictValues setValue:[NSNumber numberWithLong:2] forKey:MiaAPIKey_Type];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_PostFollow
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getRoomStat:(NSString *)roomID
	  completeBlock:(MiaRequestCompleteBlock)completeBlock
	   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Live_GetStat
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

#pragma mark - profile
+ (void)getUserProfileWithUID:(NSString *)uID
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_User_GetProfile
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getMusicianProfileWithUID:(NSString *)uID
	completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:uID forKey:MiaAPIKey_UID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Musician_GetProfile
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getAlbumWithID:(NSString *)albumID
			completeBlock:(MiaRequestCompleteBlock)completeBlock
			 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:albumID forKey:MiaAPIKey_AlbumID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Musician_GetAlbum
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getAlbumComment:(NSString *)itemID
          lastCommentID:(NSString *)lastCommentID
                  limit:(long)limit
          completeBlock:(MiaRequestCompleteBlock)completeBlock
           timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:itemID forKey:MiaAPIKey_ItemID];
	[dictValues setValue:[NSNumber numberWithLong:1] forKey:MiaAPIKey_ItemType];
	[dictValues setValue:lastCommentID forKey:MiaAPIKey_Start];
	[dictValues setValue:[NSNumber numberWithLong:limit] forKey:MiaAPIKey_Limit];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Musician_GetComment
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)postAlbumComment:(NSString *)itemID
                 content:(NSString *)content
               commentID:(NSString *)commentID
           completeBlock:(MiaRequestCompleteBlock)completeBlock
            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:itemID forKey:MiaAPIKey_ItemID];
	[dictValues setValue:[NSNumber numberWithLong:1] forKey:MiaAPIKey_ItemType];
	[dictValues setValue:content forKey:MiaAPIKey_Content];

	if (![NSString isNull:commentID]) {
		[dictValues setValue:commentID forKey:MiaAPIKey_CommentID];
	}


	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Musician_PostComment
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getReplyCommentWithRoomID:(NSString *)roomID
                         latitude:(double)lat
                        longitude:(double)lon
                             time:(long)time
                    completeBlock:(MiaRequestCompleteBlock)completeBlock
                     timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
	[dictValues setValue:[NSNumber numberWithFloat:lat] forKey:MiaAPIKey_Latitude];
	[dictValues setValue:[NSNumber numberWithFloat:lon] forKey:MiaAPIKey_Longitude];
	[dictValues setValue:[NSNumber numberWithLong:time] forKey:MiaAPIKey_Time];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Musician_Replay_GetComment
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)viewReplayWithRoomID:(NSString *)roomID
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock {
	NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
	[dictValues setValue:roomID forKey:MiaAPIKey_RoomID];

	MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Musician_Replay_PostView
															   parameters:dictValues
															completeBlock:completeBlock
															 timeoutBlock:timeoutBlock];
	[[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

#pragma mark - 充值相关

+ (void)getRechargeListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:@"APPLE" forKey:MiaAPIKey_Type];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Recharge_GetList
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getMCoinBalancesWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                             timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_MCoin_GetBalance
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)getSendGiftListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Gift_SendList
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}


+ (void)getOrderListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                         timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:@"APPLE" forKey:MiaAPIKey_TradeType];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Order_GetList
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

+ (void)verifyPurchaseWithRechargeID:(NSString *)rechargeID
                             orderID:(NSString *)orderID
                                auth:(NSString *)auth
                       completeBlock:(MiaRequestCompleteBlock)completeBlock
                        timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:@"APPLE" forKey:MiaAPIKey_TradeType];
    [dictValues setValue:rechargeID forKey:MiaAPIKey_RechargeID];
    [dictValues setValue:orderID forKey:MiaAPIKey_AppleOrderID];
    [dictValues setValue:auth forKey:MiaAPIKey_Auth];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_Verify
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

#pragma mark - M币消费相关

+ (void)rewardAlbumWithAlbumID:(NSString *)albumID
                        roomID:(NSString *)roomID
                         mCoin:(NSString *)mCoin
                 completeBlock:(MiaRequestCompleteBlock)completeBlock
                  timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:@"APPLE" forKey:MiaAPIKey_TradeType];
    [dictValues setValue:albumID forKey:MiaAPIKey_AlbumID];
    [dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
    [dictValues setValue:mCoin forKey:MiaAPIKey_MCoin];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_RewardAlbum
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}


+ (void)sendGiftWithGiftID:(NSString *)giftID
                    roomID:(NSString *)roomID
             completeBlock:(MiaRequestCompleteBlock)completeBlock
              timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock{

    NSMutableDictionary *dictValues = [[NSMutableDictionary alloc] init];
    [dictValues setValue:@"APPLE" forKey:MiaAPIKey_TradeType];
    [dictValues setValue:giftID forKey:MiaAPIKey_GiftID];
    [dictValues setValue:roomID forKey:MiaAPIKey_RoomID];
    MiaRequestItem *requestItem = [[MiaRequestItem alloc] initWithCommand:MiaAPICommand_SendGift
                                                               parameters:dictValues
                                                            completeBlock:completeBlock
                                                             timeoutBlock:timeoutBlock];
    [[WebSocketMgr standard] sendWitRequestItem:requestItem];
}

@end
