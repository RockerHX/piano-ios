//
//  MIAFontManage.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAFontManage.h"

static NSString *kMIAFontBold = @"Helvetica-Bold";
static NSString *kMIAFontRegular = @"Helvetica";
static NSString *kMIAFontLight = @"Helvetica";

@implementation MIAFontManage

+ (JOFont *)getFontWithType:(MIAFontType)type{

    if (type == MIAFontType_Cell_Title) {
        //cell的head中tilte
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }else if (type == MIAFontType_Cell_Tip){
        //cell的head中右边的tip
        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 11.);
    }
        
//MARK: 主播的Proflie页面
    if (type == MIAFontType_Profile_Head_NickName){
        //昵称
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 20.);
    }else if (type == MIAFontType_Profile_Head_Summary){
        //简介
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 13.);
    }else if (type == MIAFontType_Profile_Head_Fans){
       //粉丝数 关注人数
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 18.);
    }else if (type == MIAFontType_Profile_Head_FansTip){
        //粉丝关注的提示
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 11.);
    }else if (type == MIAFontType_Profile_Head_AttentionButtonTitle){
        //关注按钮
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 18.);
    }else if (type == MIAFontType_Profile_Live_Title){
        //直播的标题
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 15.);
    }else if (type == MIAFontType_Profile_Live_Summary){
        //直播的介绍语
        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 13.);
    }else if (type == MIAFontType_Profile_Album_Name){
        //专辑的名字
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }else if (type == MIAFontType_Profile_Album_BackTotal){
        //打赏人数
        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 10.);
    }else if (type == MIAFontType_Profile_Video_Name){
        //视频的名字
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 15.);
    }else if (type == MIAFontType_Profile_Video_ViweCount){
        //视频观看的人数
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 12.);
    }else if (type == MIAFontType_Profile_Replay_Name){
        //直播回放的名字
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }else if (type == MIAFontType_Profile_Replay_Date){
        //直播的时间
        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 10.);
    }else if (type == MIAFontType_Profile_Replay_ViweCount){
        //观看的人数
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 12.);
    }
    
//MARK: 专辑详情页面
    if (type == MIAFontType_Album_Bar_Title) {
        //Bar的Title
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 16.);
    }else if (type == MIAFontType_Album_Bar_Name){
        //Bar的名字
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 13.);
    }else if (type == MIAFontType_Album_PayDownloadButtonTitle){
        //打赏下载按钮
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 16.);
    }else if (type == MIAFontType_Album_Reward_Tip){
        //已打赏的人数
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 14.);
    }else if (type == MIAFontType_Album_Play_Time){
        //播放进度条提示的时间
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 12.);
    }else if (type == MIAFontType_Album_Song_Title){
        //音乐的标题
        return JOFontMake(kMIAFontRegular,JORGBSameCreate(180.), 17.);
    }else if (type == MIAFontType_Album_Song_Time){
        //音乐的时长
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }else if (type == MIAFontType_Album_Comment_Name){
        //评论人的名字
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 14.);
    }else if (type == MIAFontType_Album_Comment_Content){
        //评论的类容
        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 13.);
    }else if (type == MIAFontType_Album_Comment_Time){
        //评论的时间
        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 10.);
    }else if (type == MIAFontType_Album_Comment_Enter){
        //评论输入框
        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 17.);
    }else if (type == MIAFontType_Album_Comment_Send){
        //发送评论的按钮
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }
    
    //MARK: 专辑打赏页面
    if (type == MIAFontType_AlbumReward_Title) {
        //专辑的标题
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_AlbumReward_Singer){
        //演唱者
        return JOFontMake(kMIAFontRegular, JORGBSameCreate(220.), 13.);
    }else if (type == MIAFontType_AlbumReward_Tip){
        //提示
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_AlbumReward_RewardButtonTitle){
        //打赏的按钮的标题
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_AlbumReward_Account){
        //M币的账户余额
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 15.);
    }else if (type == MIAFontType_AlbumReward_Recharge){
        //充值
        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 15.);
    }
    
    return JOFontMake(kMIAFontRegular, [UIColor blackColor], 17.);
}

@end
