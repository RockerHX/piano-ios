//
//  MIASettingContentViewModel.h
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAViewModel.h"

UIKIT_EXTERN CGFloat const kSettingContentTopSpaceDistance; //头部的间距大小
UIKIT_EXTERN CGFloat const kSettingContentTextFieldHeight; //textField的高度
UIKIT_EXTERN CGFloat const kSettingContentTextViewHeight; //textView的高度
UIKIT_EXTERN CGFloat const kSettingContentTableViewCellHeight; //cell的高度


typedef NS_ENUM(NSUInteger, SettingContentType){
    
    SettingContentType_Nick, //昵称
    SettingContentType_Summary, //签名
    SettingContentType_Gender, //性别
    SettingContentType_Feedback,//意见
};

typedef NS_ENUM(NSUInteger, GenderType) {

    GenderUnknow,//未知性别
    GenderMale,//男性
    GenderFemale,//女性
};

@interface MIASettingContentViewModel : MIAViewModel

/**
 *  更改性别.
 *
 *  @param type 性别的类型.
 *
 *  @return 更改性别的状态的信号.
 */
- (RACSignal *)changeGenderWithGenderType:(GenderType)type;

/**
 *  更改昵称.
 *
 *  @param name 昵称.
 *
 *  @return 更改昵称的状态的信号.
 */
- (RACSignal *)changeNickWithName:(NSString *)name;

/**
 *  意见反馈.
 *
 *  @param content 意见的内容.
 *
 *  @return 意见提交的状态的信号.
 */
- (RACSignal *)feedbackWithContent:(NSString *)content contact:(NSString *)contact;

/**
 *  更改签名.
 *
 *  @param content 签名的内容.
 *
 *  @return 签名更改的状态的信号.
 */
- (RACSignal *)changeSummayWithContent:(NSString *)content;

@end
