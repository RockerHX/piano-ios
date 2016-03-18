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

static NSString * const MiaAPICommand_User_PushNoti			= @"User.Push.Noti";

static NSString * const MiaAPICommand_Room_GetList			= @"Live.Room.Get.Lists";
