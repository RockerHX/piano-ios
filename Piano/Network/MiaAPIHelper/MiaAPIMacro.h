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

static NSString * const MiaAPICommand_User_GetProfile		= @"User.Get.Profile";

// Notification
static NSString * const MiaAPICommand_Push_UserNoti			= @"User.Push.Noti";
static NSString * const MiaAPICommand_Push_RoomEnter		= @"Rooms.Push.Enter";
static NSString * const MiaAPICommand_Push_RoomClose		= @"Rooms.Push.Close";
static NSString * const MiaAPICommand_Push_RoomComment		= @"Rooms.Push.Comment";

// Home
static NSString * const MiaAPICommand_Room_GetList			= @"Live.Room.Get.Lists";
static NSString * const MiaAPICommand_Channel_GetHome		= @"Channel.Get.Home";

// Live
static NSString * const MiaAPICommand_Live_EnterRoom		= @"Live.Room.Post.Enter";
static NSString * const MiaAPICommand_Live_LeaveRoom		= @"Live.Room.Post.Leave";
static NSString * const MiaAPICommand_Live_CommentRoom		= @"Live.Room.Post.Comment";
static NSString * const MiaAPICommand_Live_PostCreate		= @"Live.Room.Post.Create";
static NSString * const MiaAPICommand_Live_PutTitle			= @"Live.Room.Put.Title";
static NSString * const MiaAPICommand_Live_PutCover			= @"Live.Room.Put.Cover";
static NSString * const MiaAPICommand_Live_PutLocation		= @"Live.Room.Put.Location";
static NSString * const MiaAPICommand_Live_PostForbid		= @"Live.Room.Post.Forbid";
static NSString * const MiaAPICommand_Live_GetStat			= @"Live.Room.Get.Stat";
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