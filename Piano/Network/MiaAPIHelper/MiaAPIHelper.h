//
//  MiaAPIHelper.h
//  mia
//
//  Created by linyehui on 2016/03/17.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MiaAPIMacro.h"
#import "MiaRequestItem.h"


FOUNDATION_EXPORT NSString *const TimtOutPrompt;            // 请求超时提示
FOUNDATION_EXPORT NSString *const DataParseErrorPrompt;     // 数据解析出错提示
FOUNDATION_EXPORT NSString *const UnknowErrorPrompt;        // 未知错误提示
FOUNDATION_EXPORT NSString *const MobileErrorPrompt;        // 手机号码错误提示



@interface MiaAPIHelper : NSObject

+ (id)getUUID;
+ (void)guestLoginWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)thirdLoginWithOpenID:(NSString *)openID
					 unionID:(NSString *)unionID
					   token:(NSString *)token
					nickName:(NSString *)nickName
						 sex:(NSString *)sex
						type:(NSString *)type
					  avatar:(NSString *)avatar
			   completeBlock:(MiaRequestCompleteBlock)completeBlock
				timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)loginWithMobile:(NSString *)mobile
           passwordHash:(NSString *)passwordHash
          completeBlock:(MiaRequestCompleteBlock)completeBlock
           timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)loginWithSession:(NSString *)uID
				   token:(NSString *)token
		   completeBlock:(MiaRequestCompleteBlock)completeBlock
			timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)logoutWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
				   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getVerificationCodeWithType:(long)type
						phoneNumber:(NSString *)phoneNumber
					  completeBlock:(MiaRequestCompleteBlock)completeBlock
					   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)registerWithPhoneNum:(NSString *)phoneNumber
					   scode:(NSString *)scode
					nickName:(NSString *)nickName
				passwordHash:(NSString *)passwordHash
			   completeBlock:(MiaRequestCompleteBlock)completeBlock
				timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)resetPasswordWithPhoneNum:(NSString *)phoneNumber
					 passwordHash:(NSString *)passwordHash
							scode:(NSString *)scode
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)changePasswordWithOldPasswordHash:(NSString *)oldPasswordHash
						  newPasswordHash:(NSString *)newPasswordHash
							completeBlock:(MiaRequestCompleteBlock)completeBlock
							 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)changeNickName:(NSString *)nick
		 completeBlock:(MiaRequestCompleteBlock)completeBlock
		  timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)changeGender:(long)gender
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
		timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getUploadAvatarAuthWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
								timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)uploadFinishWithFileID:(NSString *)fileID
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
		timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)feedbackWithNote:(NSString *)note
				 contact:(NSString *)contact
		   completeBlock:(MiaRequestCompleteBlock)completeBlock
			timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getHomeListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
						timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)enterRoom:(NSString *)roomID
	completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)leaveRoom:(NSString *)roomID
	completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)commentRoom:(NSString *)roomID
			content:(NSString *)content
	  completeBlock:(MiaRequestCompleteBlock)completeBlock
	   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getUserProfileWithUID:(NSString *)uID
				completeBlock:(MiaRequestCompleteBlock)completeBlock
				 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getMusicianProfileWithUID:(NSString *)uID
					completeBlock:(MiaRequestCompleteBlock)completeBlock
					 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getAlbumWithID:(NSString *)albumID
         completeBlock:(MiaRequestCompleteBlock)completeBlock
          timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getAlbumComment:(NSString *)itemID
				  start:(long)start
				  limit:(long)limit
		  completeBlock:(MiaRequestCompleteBlock)completeBlock
		   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)postAlbumComment:(NSString *)itemID
				 content:(NSString *)content
				  commentID:(NSString *)commentID
		   completeBlock:(MiaRequestCompleteBlock)completeBlock
			timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

@end
