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

    //MARK: 主播的Profile页面
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
    
    //MARK: 专辑详情页
    MIAFontType_Album_Bar_Title,//Bar的标题
    MIAFontType_Album_Bar_Name,//Bar的名字
    MIAFontType_Album_PayDownloadButtonTitle,//打赏下载按钮
    MIAFontType_Album_Reward_Tip,//已打赏的人数
    MIAFontType_Album_Play_Time,//播放进度条提示的时间
    MIAFontType_Album_Song_Title,//音乐的标题
    MIAFontType_Album_Song_Time,//音乐的时长
    MIAFontType_Album_Comment_Name,//评论人的名字
    MIAFontType_Album_Comment_Content,//评论的类容
    MIAFontType_Album_Comment_Time,//评论的时间
    MIAFontType_Album_Comment_Enter,//评论输入框
    MIAFontType_Album_Comment_Send,//发送评论的按钮
    
    //MARK: 专辑打赏页面
    MIAFontType_AlbumReward_Title,//专辑的标题
    MIAFontType_AlbumReward_Singer,//演唱者
    MIAFontType_AlbumReward_Tip,//提示
    MIAFontType_AlbumReward_RewardMCoin,//打赏的M币金额
    MIAFontType_AlbumReward_RewardButtonTitle,//打赏的按钮的标题
    MIAFontType_AlbumReward_Account,//M币的账户余额
    MIAFontType_AlbumReward_Recharge,//充值
    
    //MARK: 充值页面
    MIAFontType_Payment_Bar_Title, //Bar视图的标题
    MIAFontType_Payment_Bar_RightButton, //Bar视图右边的按钮(消费记录)
    MIAFontType_Payment_Bar_M_Tip, //Bar视图的M币的剩余提示
    MIAFontType_Payment_Bar_M,//Bar视图的M币
    MIAFontType_Payment_Pay_M, //充值的M币
    MIAFontType_Payment_Pay_Money, //充值的金额
    MIAFontType_Payment_Pay_Head, //充值的head提示
    MIAFontType_Payment_Alert_Title,//提示的标题
    MIAFontType_Payment_Alert_Content,//提示的内容
    MIAFontType_Payment_Alert_Button,//提示的按钮
    
    //MARK: 消费的记录
    MIAFontType_PayHistory_HeadTip,//头部的提示模块标题
    MIAFontType_PayHistory_Title, //标题
    MIAFontType_PayHistory_Time,  //时间
    MIAFontType_PayHistory_Amount, //余额
    
    
};


@interface MIAFontManage : NSObject

+ (JOFont *)getFontWithType:(MIAFontType)type;

@end
