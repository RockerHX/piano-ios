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
static NSString * const MiaAPIKey_Error						= @"err";

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
static NSString * const MiaAPIKey_UID						= @"uid";

static NSString * const MiaAPICommand_User_PostLogout		= @"User.Post.Logout";

static NSString * const MiaAPICommand_User_PostChangePwd	= @"User.Post.Cpwd";
static NSString * const MiaAPIKey_OldPwd					= @"opwd";
static NSString * const MiaAPIKey_NewPwd					= @"npwd";

static NSString * const MiaAPICommand_User_PostCnick		= @"User.Post.Cnick";
static NSString * const MiaAPICommand_User_PostGender		= @"User.Post.Gender";
static NSString * const MiaAPIKey_Gender					= @"gender";

static NSString * const MiaAPICommand_User_PushNoti			= @"User.Push.Noti";

static NSString * const MiaAPICommand_Room_GetList			= @"Live.Room.Get.Lists";
