//
//  MIAFontManage.h
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JOBaseSDK.h"

typedef NS_ENUM(NSUInteger, MIAFontType) {
    
    MIAFontType_Cell_Title, //cell的head中tilte
    MIAFontType_Cell_Tip,   //cell的head中右边的tip

    MIAFontType_Profile_Head_NickName,//昵称
    MIAFontType_Profile_Head_Summary, //简介
    MIAFontType_Profile_Head_Fans,  //粉丝数 关注人数
    MIAFontType_Profile_Head_FansTip, //粉丝关注的提示
    MIAFontType_Profile_Head_AttentionButtonTitle,//关注按钮
    
    MIAFontType_Profile_Live_Title,//直播的标题
    MIAFontType_Profile_Live_Summary,//直播的介绍语
    
    MIAFontType_Profile_Album_Name,//专辑的名字
    MIAFontType_Profile_Album_BackTotal,//打赏人数
    
    MIAFontType_Profile_Video_Name,//视频的名字
    MIAFontType_Profile_Video_ViweCount,//视频观看的人数
    
    MIAFontType_Profile_Replay_Name,//直播回放的名字
    MIAFontType_Profile_Replay_Date, //直播的时间
    MIAFontType_Profile_Replay_ViweCount,//观看的人数
    
};


@interface MIAFontManage : NSObject

+ (JOFont)getFontWithType:(MIAFontType)type;

@end
