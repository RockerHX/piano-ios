//
//  MiaAPIMacro.h
//  mia
//
//  Created by linyehui on 2015/09/08.
//  Copyright (c) 2015年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const MiaAPIProtocolVersion				= @"1";
static NSString * const MiaAPIDefaultIMEI					= @"ios";

static NSString * const MiaAPIKey_ServerCommand				= @"C";
static NSString * const MiaAPIKey_ClientCommand				= @"c";
static NSString * const MiaAPIKey_Version					= @"r";
static NSString * const MiaAPIKey_Timestamp					= @"s";
static NSString * const MiaAPIKey_Values					= @"v";
static NSString * const MiaAPIKey_Return					= @"ret";
static NSString * const MiaAPIKey_Data						= @"data";
static NSString * const MiaAPIKey_Error						= @"err";

// User
static NSString * const MiaAPICommand_User_PostGuest		= @"User.Post.Guest";
static NSString * const MiaAPIKey_GUID						= @"guid";

static NSString * const MiaAPICommand_User_PostPauth		= @"User.Post.Pauth";
static NSString * const MiaAPIKey_Type						= @"type";
static NSString * const MiaAPIKey_PhoneNumber				= @"phone";
static NSString * const MiaAPIKey_IMEI						= @"imei";

static NSString * const MiaAPICommand_User_PostRegister		= @"User.Post.Register";
static NSString * const MiaAPIKey_SCode						= @"scode";
static NSString * const MiaAPIKey_Nick                      = @"nick";
static NSString * const MiaAPIKey_Password					= @"pass";

static NSString * const MiaAPICommand_User_PostThirdLogin   = @"User.Post.Passport";
static NSString * const MiaAPIKey_OpenID                    = @"openid";
static NSString * const MiaAPIKey_UnionID                   = @"unionid";
static NSString * const MiaAPIKey_Token                     = @"token";
static NSString * const MiaAPIKey_NickName                  = @"nickname";
static NSString * const MiaAPIKey_From                      = @"from";
static NSString * const MiaAPIKey_Sex                       = @"sex";
static NSString * const MiaAPIKey_HeadImageURL              = @"headimgurl";

static NSString * const MiaAPICommand_User_PostLogin		= @"User.Post.Login";
static NSString * const MiaAPIKey_Pwd						= @"pwd";
static NSString * const MiaAPIKey_Dev						= @"dev";

static NSString * const MiaAPICommand_User_PostSession		= @"User.Post.Session";
static NSString * const MiaAPIKey_UID						= @"uID";

static NSString * const MiaAPICommand_User_PostLogout		= @"User.Post.Logout";

static NSString * const MiaAPICommand_User_PostChangePwd	= @"User.Post.Cpwd";
static NSString * const MiaAPIKey_OldPwd					= @"opwd";
static NSString * const MiaAPIKey_NewPwd					= @"npwd";

static NSString * const MiaAPICommand_User_PostCnick		= @"User.Post.Cnick";
static NSString * const MiaAPICommand_User_PostGender		= @"User.Post.Gender";
static NSString * const MiaAPIKey_Gender					= @"gender";

static NSString * const MiaAPICommand_User_GetUpload		= @"User.Get.Upload";
static NSString * const MiaAPICommand_User_PostUploadfinish	= @"User.Post.Uploadfinish";
static NSString * const MiaAPIKey_fileID					= @"fileID";

static NSString * const MiaAPICommand_User_Feedback			= @"User.Post.Feedback";
static NSString * const MiaAPIKey_Note						= @"note";
static NSString * const MiaAPIKey_Contact					= @"contact";
static NSString * const MiaAPIKey_Platform					= @"platform";
static NSString * const MiaAPIKey_OSVersion					= @"osversion";

static NSString * const MiaAPICommand_User_Bio              = @"User.Post.Bio";//修改签名
static NSString * const MiaAPIKey_Bio                       = @"bio";

static NSString * const MiaAPICommand_User_GetProfile		= @"User.Get.Profile";

// Notification
static NSString * const MiaAPICommand_Push_UserNoti			= @"User.Push.Noti";
static NSString * const MiaAPICommand_Push_RoomEnter		= @"Rooms.Push.Enter";
static NSString * const MiaAPICommand_Push_RoomClose		= @"Rooms.Push.Close";
static NSString * const MiaAPICommand_Push_RoomGift         = @"Rooms.Push.Gift";
static NSString * const MiaAPICommand_Push_RoomReward		= @"Rooms.Push.Album";
static NSString * const MiaAPICommand_Push_RoomComment		= @"Rooms.Push.Comment";
static NSString * const MiaAPICommand_Push_Share            = @"Rooms.Push.Share";
static NSString * const MiaAPICommand_Push_Attention        = @"Rooms.Push.Follow";

// Home
static NSString * const MiaAPICommand_Room_GetList			= @"Live.Room.Get.Lists";
static NSString * const MiaAPICommand_Channel_GetHome		= @"Channel.Get.Home";
static NSString * const MiaAPICommand_Channel_GetMusician	= @"Channel.Get.Musician";

// Live
static NSString * const MiaAPICommand_Live_EnterRoom		= @"Live.Room.Post.Enter";
static NSString * const MiaAPICommand_Live_LeaveRoom		= @"Live.Room.Post.Leave";
static NSString * const MiaAPICommand_Live_GetAlbumList     = @"Musician.Get.Albumlist";
static NSString * const MiaAPICommand_Live_RelatedAlbum     = @"Live.Room.Put.Album";
static NSString * const MiaAPICommand_Live_CommentRoom		= @"Live.Room.Post.Comment";
static NSString * const MiaAPICommand_Live_PostCreate		= @"Live.Room.Post.Create";
static NSString * const MiaAPICommand_Live_PutTitle			= @"Live.Room.Put.Title";
static NSString * const MiaAPICommand_Live_PutCover			= @"Live.Room.Put.Cover";
static NSString * const MiaAPICommand_Live_PutLocation		= @"Live.Room.Put.Location";
static NSString * const MiaAPICommand_Live_PostForbid		= @"Live.Room.Post.Forbid";
static NSString * const MiaAPICommand_User_PostFollow		= @"User.Post.Follow";
static NSString * const MiaAPICommand_User_GetFollow		= @"User.Get.Follow";
static NSString * const MiaAPICommand_Live_GetStat			= @"Live.Room.Get.Stat";
static NSString * const MiaAPICommand_Live_GetGiftList      = @"Live.Room.Get.Gift";
static NSString * const MiaAPICommand_Live_AlbumAnimation   = @"Live.Room.Album.Animate";
static NSString * const MiaAPICommand_Live_GetGiftTopList   = @"Live.Room.Top.Gift";
static NSString * const MiaAPICommand_Live_GetAlbumTopList  = @"Live.Room.Top.Album";
static NSString * const MiaAPICommand_Live_SharePost        = @"Live.Room.Post.Share";
static NSString * const MiaAPICommand_Live_Close            = @"Live.Room.Post.Close";
static NSString * const MiaAPICommand_Live_PostBackend      = @"Live.Room.Post.Backend";
static NSString * const MiaAPICommand_Live_Backend          = @"Rooms.Push.Backend";
static NSString * const MiaAPICommand_Live_ReFetch          = @"Live.Room.Get.Live";
static NSString * const MiaAPIKey_RoomID					= @"roomID";
static NSString * const MiaAPIKey_Content					= @"content";
static NSString * const MiaAPIKey_Title						= @"title";
static NSString * const MiaAPIKey_CoverID					= @"coverID";
static NSString * const MiaAPIKey_Latitude					= @"lat";
static NSString * const MiaAPIKey_Longitude					= @"lng";
static NSString * const MiaAPIKey_Address					= @"addr";

// Musician
static NSString * const MiaAPICommand_Musician_GetProfile	= @"Musician.Get.Profile";

static NSString * const MiaAPICommand_Musician_GetAlbum		= @"Musician.Get.Album";
static NSString * const MiaAPIKey_AlbumID					= @"albumID";

static NSString * const MiaAPICommand_Musician_GetComment	= @"Musician.Get.Comment";
static NSString * const MiaAPIKey_CommentID					= @"commentID";

static NSString * const MiaAPICommand_Musician_PostComment	= @"Musician.Post.Comment";
static NSString * const MiaAPIKey_ItemID					= @"itemID";
static NSString * const MiaAPIKey_ItemType					= @"itemType";
static NSString * const MiaAPIKey_Start						= @"start";
static NSString * const MiaAPIKey_Limit						= @"limit";


static NSString * const MiaAPICommand_Musician_Replay_GetComment	= @"Musician.Replay.Get.Comment";
static NSString * const MiaAPIKey_Time                       		= @"time";

static NSString * const MiaAPICommand_Musician_Replay_PostView		= @"Musician.Replay.Post.View";

//purchase
static NSString * const MiaAPICommand_Recharge_GetList      = @"User.Get.Recharge"; //充值列表
static NSString * const MiaAPICommand_MCoin_GetBalance      = @"User.Get.Mcoin";    //我的M币余额
static NSString * const MiaAPICommand_Gift_ReceiverList     = @"Musician.Get.Gift";//收到的礼物列表
static NSString * const MiaAPICommand_Gift_SendList         = @"User.Get.Gift";     //送出礼物列表
static NSString * const MiaAPICommand_Order_GetList         = @"User.Get.Order";    //充值记录
static NSString * const MiaAPICommand_Verify                = @"User.Post.Order"; //服务器验证

static NSString * const MiaAPICommand_PlatForm              = @"platform"; //1ios, 2android, 3pc, 4 weixin
//static NSString * const MiaAPICommand_PayType               = @"payType"; //1为应用里的微信支付 3微信扫码支付, 5为ios支付, 4支付宝
static NSString * const MiaAPIKey_TradeType                 = @"tradeType"; // 订单号验证的渠道  Apple
static NSString * const MiaAPIKey_RechargeID                = @"rechargeID"; // 购买产品的id
static NSString * const MiaAPIKey_AppleOrderID              = @"appleOrderID"; //苹果生成的订单号
static NSString * const MiaAPIKey_Auth                      = @"auth"; //验证的串

static NSString * const MiaAPICommand_RewardAlbum           = @"User.Album.Post.Back";//打赏专辑
static NSString * const MiaAPICommand_SendGift              = @"User.Gift.Post.Back";//送礼物

static NSString * const MiaAPIKey_MCoin                     = @"mcoin";//M币
static NSString * const MiaAPIKey_GiftID                    = @"giftID";//礼物的id
static NSString * const MiaAPIKey_GiftNum                   = @"giftNum";//礼物的数量

//log upload
static NSString * const MiaAPICommand_LogUpload             = @"Live.Room.Post.Log";//上传日志

//Report
static NSString * const MiaAPICommand_Report                = @"User.Post.Report";//举报

//Video count
static NSString * const MiaAPICommand_VideoCount            = @"Musician.Video.Play";//视频统计
static NSString * const MiaAPIKey_VideoID                   = @"id"; //视频的id

//Income
static NSString * const MiaAPICommand_Income                = @"Musician.Get.Income";//我的收益

