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

+ (void)getUploadAuthWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
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

+ (void)getMusiciansWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
						 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;


+ (void)enterRoom:(NSString *)roomID
	completeBlock:(MiaRequestCompleteBlock)completeBlock
     timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)leaveRoom:(NSString *)roomID
    completeBlock:(MiaRequestCompleteBlock)completeBlock
     timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)liveGetAlbumListWithUID:(NSString *)UID
                          start:(NSInteger)start
                          limit:(NSInteger)limit
                  completeBlock:(MiaRequestCompleteBlock)completeBlock
                   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)commentRoom:(NSString *)roomID
			content:(NSString *)content
	  completeBlock:(MiaRequestCompleteBlock)completeBlock
	   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)createRoomWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
					   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)liveRelatedAlbum:(NSString *)albumID
                  roomID:(NSString *)roomID
           completeBlock:(MiaRequestCompleteBlock)completeBlock
            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)setRoomTitle:(NSString *)title
			  roomID:(NSString *)roomID
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)setRoomCover:(NSString *)coverID
			  roomID:(NSString *)roomID
	   completeBlock:(MiaRequestCompleteBlock)completeBlock
	 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)setRoomLocationWithLatitude:(double)lat
						  longitude:(double)lon
							address:(NSString *)address
							 roomID:(NSString *)roomID
					  completeBlock:(MiaRequestCompleteBlock)completeBlock
					   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)forbidUser:(NSString *)uID
	 completeBlock:(MiaRequestCompleteBlock)completeBlock
	  timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getFollowStateWithUID:(NSString *)uID
                completeBlock:(MiaRequestCompleteBlock)completeBlock
                 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)followWithUID:(NSString *)uID
		completeBlock:(MiaRequestCompleteBlock)completeBlock
		 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)unfollowWithUID:(NSString *)uID
		  completeBlock:(MiaRequestCompleteBlock)completeBlock
		   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getRoomStat:(NSString *)roomID
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
          lastCommentID:(NSString *)lastCommentID
				  limit:(long)limit
		  completeBlock:(MiaRequestCompleteBlock)completeBlock 
		   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)postAlbumComment:(NSString *)itemID
				 content:(NSString *)content
               commentID:(NSString *)commentID
		   completeBlock:(MiaRequestCompleteBlock)completeBlock
			timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getReplyCommentWithRoomID:(NSString *)roomID
                         latitude:(double)lat
                        longitude:(double)lon
                             time:(long)time
                    completeBlock:(MiaRequestCompleteBlock)completeBlock
                     timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)viewReplayWithRoomID:(NSString *)roomID
			   completeBlock:(MiaRequestCompleteBlock)completeBlock
				timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

#pragma mark - 充值相关

/**
 *  获取充值的列表数据
 *
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getRechargeListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;


/**
 *  获取我的M币余额.
 *
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getMCoinBalancesWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                             timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

/**
 *  获取送出的礼物列表.
 *
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getSendGiftListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

/**
 *  获取充值的记录列表.
 *
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getOrderListWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                         timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

@end
