//
//  MIAFontManage.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAFontManage.h"

//static NSString *kMIAFontBold = @".SFUIText-Body";
//static NSString *kMIAFontRegular = @".SFUIText-Regular";
//static NSString *kMIAFontLight = @".SFUIText-Light";

@implementation MIAFontManage

+ (JOFont *)getFontWithType:(MIAFontType)type{

    
    if (type == MIAFontType_NavBar_Title) {
        //NavBar的标题
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightBold], [UIColor whiteColor]);
    }
    
    if (type == MIAFontType_Cell_Title) {
        //cell的head中tilte
        return JOFontsMake([UIFont systemFontOfSize:16. weight:UIFontWeightRegular], [UIColor blackColor]);
    }else if (type == MIAFontType_Cell_Tip){
        //cell的head中右边的tip
        return JOFontsMake([UIFont systemFontOfSize:12. weight:UIFontWeightRegular], JORGBSameCreate(160.));
    }
    
    //MARK: 我的Profile页面
    if (type == MIAFontType_Host_Attention_Title) {
        //我的profile关注人的名字
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], JORGBSameCreate(160.));
    }else if (type == MIAFontType_Host_Attention_Live){
        //我的profile关注人的直播提示
        return JOFontsMake([UIFont systemFontOfSize:11. weight:UIFontWeightRegular], JORGBCreate(255,87,115,1.));
    }else if (type == MIAFontType_Host_Album_Name){
        //打赏的专辑名字
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], JORGBSameCreate(160.));
    }else if (type == MIAFontType_Host_Head_Nick){
        //昵称
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightBold], [UIColor whiteColor]);
    }else if (type == MIAFontType_Host_Head_Summary){
        //简介
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightBold], JORGBSameCreate(128.));
    }else if (type == MIAFontType_Host_Attention_Empty){
        //关注的人为空的提示
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightBold], JORGBSameCreate(128.));
    }else if (type == MIAFontType_Host_Album_Empty){
        //专辑为空的提示
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightBold], JORGBSameCreate(128.));
    }
        
//MARK: 主播的Proflie页面
    if (type == MIAFontType_Profile_Head_NickName){
        //昵称
        return JOFontsMake([UIFont systemFontOfSize:27. weight:UIFontWeightRegular], [UIColor whiteColor]);
    }else if (type == MIAFontType_Profile_Head_Summary){
        //简介
        return JOFontsMake([UIFont systemFontOfSize:19. weight:UIFontWeightRegular], [UIColor whiteColor]);
    }else if (type == MIAFontType_Profile_Head_Fans){
       //粉丝数 关注人数
        return JOFontsMake([UIFont systemFontOfSize:22. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 22.);
    }else if (type == MIAFontType_Profile_Head_FansTip){
        //粉丝关注的提示
        return JOFontsMake([UIFont systemFontOfSize:12. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 12.);
    }else if (type == MIAFontType_Profile_Head_AttentionButtonTitle){
        //关注按钮
        return JOFontsMake([UIFont systemFontOfSize:22. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 22.);
    }else if (type == MIAFontType_Profile_Live_Title){
        //直播的标题
        return JOFontsMake([UIFont systemFontOfSize:16. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 16.);
    }else if (type == MIAFontType_Profile_Live_Summary){
        //直播的介绍语
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], JORGBSameCreate(160.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(160.), 14.);
    }else if (type == MIAFontType_Profile_Album_Name){
        //专辑的名字
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], JORGBSameCreate(38.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(38.), 14.);
    }else if (type == MIAFontType_Profile_Album_BackTotal){
        //打赏人数
        return JOFontsMake([UIFont systemFontOfSize:10. weight:UIFontWeightRegular], [UIColor grayColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 10.);
    }else if (type == MIAFontType_Profile_Video_Name){
        //视频的名字
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 14.);
    }else if (type == MIAFontType_Profile_Video_ViweCount){
        //视频观看的人数
        return JOFontsMake([UIFont systemFontOfSize:12. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 12.);
    }else if (type == MIAFontType_Profile_Replay_Name){
        //直播回放的名字
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], JORGBSameCreate(38.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(38.), 14.);
    }else if (type == MIAFontType_Profile_Replay_Date){
        //直播的时间
        return JOFontsMake([UIFont systemFontOfSize:10. weight:UIFontWeightRegular], [UIColor grayColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 10.);
    }else if (type == MIAFontType_Profile_Replay_ViweCount){
        //观看的人数
        return JOFontsMake([UIFont systemFontOfSize:12. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 12.);
    }
    
//MARK: 专辑详情页面
    if (type == MIAFontType_Album_Bar_Title) {
        //Bar的Title
        return JOFontsMake([UIFont systemFontOfSize:16. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 16.);
    }else if (type == MIAFontType_Album_Bar_Name){
        //Bar的名字
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 13.);
    }else if (type == MIAFontType_Album_PayDownloadButtonTitle){
        //打赏下载按钮
        return JOFontsMake([UIFont systemFontOfSize:16. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 16.);
    }else if (type == MIAFontType_Album_Reward_Tip){
        //已打赏的人数
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 14.);
    }else if (type == MIAFontType_Album_Play_Time){
        //播放进度条提示的时间
        return JOFontsMake([UIFont systemFontOfSize:12. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 12.);
    }else if (type == MIAFontType_Album_Song_Title){
        //音乐的标题
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], JORGBSameCreate(190.));
//        return JOFontMake(kMIAFontRegular,JORGBSameCreate(180.), 17.);
    }else if (type == MIAFontType_Album_Song_Time){
        //音乐的时长
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }else if (type == MIAFontType_Album_Comment_Name){
        //评论人的名字
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 14.);
    }else if (type == MIAFontType_Album_Comment_Content){
        //评论的类容
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], [UIColor grayColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 13.);
    }else if (type == MIAFontType_Album_Comment_Time){
        //评论的时间
        return JOFontsMake([UIFont systemFontOfSize:10. weight:UIFontWeightRegular], JORGBSameCreate(187.));
//        return JOFontMake(kMIAFontRegular, [UIColor grayColor], 10.);
    }else if (type == MIAFontType_Album_Comment_Enter){
        //评论输入框
        return JOFontsMake([UIFont systemFontOfSize:14. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 17.);
    }else if (type == MIAFontType_Album_Comment_Send){
        //发送评论的按钮
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }
    
    //MARK: 专辑打赏页面
    if (type == MIAFontType_AlbumReward_Title) {
        //专辑的标题
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_AlbumReward_Singer){
        //演唱者
        return JOFontsMake([UIFont systemFontOfSize:12. weight:UIFontWeightRegular], JORGBSameCreate(220.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(220.), 13.);
    }else if (type == MIAFontType_AlbumReward_Tip){
        //提示
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_AlbumReward_RewardMCoin){
        //打赏的M币数量
        return JOFontsMake([UIFont systemFontOfSize:30. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 22.);
    }else if (type == MIAFontType_AlbumReward_RewardButtonTitle){
        //打赏的按钮的标题
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_AlbumReward_Account){
        //M币的账户余额
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 15.);
    }else if (type == MIAFontType_AlbumReward_Recharge){
        //充值
        return JOFontsMake([UIFont systemFontOfSize:18. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 15.);
    }
    
    //MARK: 充值页面
    if (type == MIAFontType_Payment_Bar_Title) {
        //Bar视图的标题
        return JOFontsMake([UIFont systemFontOfSize:20. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 20.);
    }else if (type == MIAFontType_Payment_Bar_RightButton){
        //Bar视图右边的按钮(消费记录)
        return JOFontsMake([UIFont systemFontOfSize:17. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 17.);
    }else if (type == MIAFontType_Payment_Bar_M_Tip){
        //Bar视图的M币的剩余提示
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 15.);
    }else if (type == MIAFontType_Payment_Bar_M){
        //Bar视图的M币
        return JOFontsMake([UIFont systemFontOfSize:32. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontBold, [UIColor whiteColor], 32.);
    }else if (type == MIAFontType_Payment_Pay_M){
        //充值的M币
        return JOFontsMake([UIFont systemFontOfSize:16. weight:UIFontWeightBold], [UIColor blackColor]);
//        return JOFontMake(kMIAFontBold, [UIColor blackColor], 16.);
    }else if (type == MIAFontType_Payment_Pay_Money){
        //充值的金额
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightBold], JORGBCreate(153., 100., 0., 1.));
//        return JOFontMake(kMIAFontBold, JORGBCreate(153., 100., 0., 1.), 15.);
    }else if (type == MIAFontType_Payment_Pay_Head){
        //充值的head提示
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 15.);
    }else if (type == MIAFontType_Payment_Alert_Title){
        //提示的标题
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 15.);
    }else if (type == MIAFontType_Payment_Alert_Content){
        //提示的内容
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }else if (type == MIAFontType_Payment_Alert_Button){
        //提示的按钮
        return JOFontsMake([UIFont systemFontOfSize:13. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 13.);
    }
    
    //MARK: 消费的记录
    if (type == MIAFontType_PayHistory_HeadTip) {
        //头部的提示模块标题
        return JOFontsMake([UIFont systemFontOfSize:15 weight:UIFontWeightRegular], JORGBSameCreate(160.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(160.), 19.);
    }else if (type == MIAFontType_PayHistory_Title){
        //标题
        return JOFontsMake([UIFont systemFontOfSize:17. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 17.);
    }else if (type == MIAFontType_PayHistory_Time){
        //时间
        return JOFontsMake([UIFont systemFontOfSize:11. weight:UIFontWeightRegular], JORGBSameCreate(160.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(210.), 13.);
    }else if (type == MIAFontType_PayHistory_Amount){
        //余额
        return JOFontsMake([UIFont systemFontOfSize:23. weight:UIFontWeightRegular], JORGBCreate(159., 144., 98.,1.));
//        return JOFontMake(kMIAFontRegular, JORGBCreate(171., 143., 71., 1.), 17.);
    }
    
    //MARK: 设置
    if (type == MIAFontType_Setting_CellTitle) {
        //设置页面的cell的标题
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 14.);
    }else if (type == MIAFontType_Setting_CellContent){
        //设置页面的cell的内容
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], JORGBSameCreate(220.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(220.), 14.);
    }else if (type == MIAFontType_Setting_Title){
        //Bar的标题
        return JOFontsMake([UIFont systemFontOfSize:19. weight:UIFontWeightRegular], [UIColor whiteColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor whiteColor], 19.);
    }
    
    //MARK: 设置的Content页面
    if (type == MIAFontType_SettingContent_Content) {
        //设置的Content的内容
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 15.);
    }else if (type == MIAFontType_SettingContent_Feedback_Tip){
        //意见的提示用语
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], [UIColor blackColor]);
//        return JOFontMake(kMIAFontRegular, [UIColor blackColor], 15.);
    }
    
    if (type == MIAFontType_PlayVideo_Time) {
        return JOFontsMake([UIFont systemFontOfSize:15. weight:UIFontWeightRegular], JORGBSameCreate(230.));
//        return JOFontMake(kMIAFontRegular, JORGBSameCreate(230.), 15.);
    }
    return JOFontsMake([UIFont systemFontOfSize:17. weight:UIFontWeightRegular], [UIColor blackColor]);
//    return JOFontMake(kMIAFontRegular, [UIColor blackColor], 17.);
}

@end
