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

/**
 *  修改签名.
 *
 *  @param bio           修改的签名的内容.
 *  @param completeBlock MiaRequestCompleteBlock.
 *  @param timeoutBlock  MiaRequestTimeoutBlock.
 */
+ (void)changeBio:(NSString *)bio
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

+ (void)followWithRoomID:(NSString *)roomID
                     uID:(NSString *)uID
           completeBlock:(MiaRequestCompleteBlock)completeBlock
            timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)unfollowWithUID:(NSString *)uID
		  completeBlock:(MiaRequestCompleteBlock)completeBlock
		   timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getRoomStat:(NSString *)roomID
	  completeBlock:(MiaRequestCompleteBlock)completeBlock
       timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getGiftListCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                    timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getGiftTopListWithRoomID:(NSString *)roomID
                   completeBlock:(MiaRequestCompleteBlock)completeBlock
                    timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)getAlbumTopListWithRoomID:(NSString *)roomID
                    completeBlock:(MiaRequestCompleteBlock)completeBlock
                     timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)sharePostWithRoomID:(NSString *)roomID
              completeBlock:(MiaRequestCompleteBlock)completeBlock
               timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)closeLiveWithRoomID:(NSString *)roomID
              completeBlock:(MiaRequestCompleteBlock)completeBlock
               timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

+ (void)refetchLiveWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
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
 *  @param start         起始的位置.
 *  @param limit         每次拉取的数量
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getSendGiftListWithStart:(NSString *)start
                           limit:(NSString *)limit
                   completeBlock:(MiaRequestCompleteBlock)completeBlock
                    timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

/**
 *  获取充值的记录列表.
 *
 *  @param start         起始的位置.
 *  @param limit         每次拉取的数量
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getOrderListWithStart:(NSString *)start
                        limit:(NSString *)limit
                completeBlock:(MiaRequestCompleteBlock)completeBlock
                 timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

/**
 *  获取接收到的礼物列表.
 *
 *  @param start         起始位置.
 *  @param limit         每次拉取的数量.
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getReceiverListWithStart:(NSString *)start
                           limit:(NSString *)limit
                   completeBlock:(MiaRequestCompleteBlock)completeBlock
                    timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;


/**
 *  内购成功后向服务器发起验证
 *
 *  @param rechargeID    内购产品的id PS:是由自己服务器给定的那个id
 *  @param orderID       苹果返回的订单号
 *  @param auth          需要拿去验证的base64的字符串.
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)verifyPurchaseWithRechargeID:(NSString *)rechargeID
                             orderID:(NSString *)orderID
                                auth:(NSString *)auth
                       completeBlock:(MiaRequestCompleteBlock)completeBlock
                        timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

#pragma mark - M币消费相关

/**
 *  打赏专辑
 *
 *  @param albumID       专辑的id
 *  @param roomID        房间的id
 *  @param mCoin         M的数量
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)rewardAlbumWithAlbumID:(NSString *)albumID
                        roomID:(NSString *)roomID
                         mCoin:(NSString *)mCoin
                 completeBlock:(MiaRequestCompleteBlock)completeBlock
                  timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

/**
 *  送礼物
 *
 *  @param giftID        礼物的id
 *  @param roomID        房间的id
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)sendGiftWithGiftID:(NSString *)giftID
                 giftCount:(NSString *)giftCount
                    roomID:(NSString *)roomID
             completeBlock:(MiaRequestCompleteBlock)completeBlock
              timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

#pragma mark - Log 上传

/**
 *  获取需要上传log日志的相关信息.
 *
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)getUploadLogWithCompleteBlock:(MiaRequestCompleteBlock)completeBlock
                          timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

/**
 *  上传日志.
 *
 *  @param roomID        房间的id
 *  @param content       上传的一些内容.
 *  @param fileID        文件的id
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)uploadLogWithRoomID:(NSString *)roomID
                    content:(NSString *)content
                     fileID:(NSString *)fileID
              completeBlock:(MiaRequestCompleteBlock)completeBlock
               timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

#pragma mark - 举报 

/**
 *  举报.
 *
 *  @param type          举报的type.
 *  @param content       举报的内容.
 *  @param completeBlock MiaRequestCompleteBlock
 *  @param timeoutBlock  MiaRequestTimeoutBlock
 */
+ (void)reportWithType:(NSString *)type
               content:(NSString *)content
         completeBlock:(MiaRequestCompleteBlock)completeBlock
          timeoutBlock:(MiaRequestTimeoutBlock)timeoutBlock;

@end
