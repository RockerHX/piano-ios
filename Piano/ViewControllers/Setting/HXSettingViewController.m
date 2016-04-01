//
//  HXSettingViewController.m
//  mia
//
//  Created by miaios on 15/11/20.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "HXSettingViewController.h"
#import "MBProgressHUDHelp.h"
#import "MiaAPIHelper.h"
#import "HXAlertBanner.h"
#import "FileLog.h"
#import "HXFeedBackViewController.h"
#import "CacheHelper.h"
#import "ChangePwdViewController.h"
#import "GenderPickerView.h"
#import "UIImage+Extrude.h"
#import "UIImageView+WebCache.h"
#import "UserSetting.h"
#import "AFNetworking.h"
#import "HXUserSession.h"
#import "NSObject+LoginAction.h"

typedef NS_ENUM(NSUInteger, HXSettingSection) {
    HXSettingSectionUser,
    HXSettingSectionAction,
    HXSettingSectionApp,
    HXSettingSectionLogout
};

typedef NS_ENUM(NSUInteger, HXUserSectionRow) {
    HXUserSectionRowAvatar,
    HXUserSectionRowNickName,
    HXUserSectionRowGender,
    HXUserSectionRowPassWord,
    HXUserSectionRowMessageCenter
};

typedef NS_ENUM(NSUInteger, HXActionSectionRow) {
    HXActionSectionRowNetwork,
    HXActionSectionRowCache
};

typedef NS_ENUM(NSUInteger, HXAppSectionRow) {
    HXAppSectionRowFeedBack,
    HXAppSectionRowVersion
};

@interface HXSettingViewController () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextFieldDelegate,
GenderPickerViewDelegate
>
@end

@implementation HXSettingViewController {
    UIImage *_uploadingImage;
    MBProgressHUD *_uploadAvatarProgressHUD;
    NSString *_lastNickName;
    MIAGender _lastGender;
    
    NSInteger _uploadLogClickTimes;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

+ (NSString *)navigationControllerIdentifier {
    return @"HXSettingNavigationController";
}

+ (HXStoryBoardName)storyBoardName {
    return HXStoryBoardNameSetting;
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [self loadAvatar];
    [self loadNickName];
    [self loadNetworkingSetting];
    [self checkCacheSize];
    [self loadVersion];
}

- (void)viewConfigure {
    ;
}

- (void)loadAvatar {
	NSString *nickName = [HXUserSession session].user.nickName;
	[_nickNameTextField setText:nickName];
	 _lastNickName = nickName;

	[_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl]
						placeholderImage:[UIImage imageNamed:@"C-AvatarDefaultIcon"]];
//	[self updateGenderLabel:gender];
}

- (void)loadNickName {
    _nickNameTextField.text = [HXUserSession session].nickName;
}

- (void)loadNetworkingSetting {
    [_networkingSwitch setOn:[UserSetting playWith3G]];
}

- (void)checkCacheSize {
    [CacheHelper checkCacheSizeWithCompleteBlock:^(unsigned long long cacheSize) {
        float sizeWithMB = cacheSize / 1024 / 1024;
        [_cacheLabel setText:[NSString stringWithFormat:@"%.0f MB", sizeWithMB]];
    }];
}

- (void)loadVersion {
    NSString *buildVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    NSString *shortVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *version = [NSString stringWithFormat:@"%@.%@", shortVersion, buildVersion];
    _versionLabel.text = version;
}

#pragma mark - Action Methods
- (IBAction)playWith3GSwitchAction:(UISwitch *)sender {
    [UserSetting setPlayWith3G:sender.isOn];
}

#pragma mark - Private Methods
- (void)uploadAvatarWithUrl:(NSString *)url auth:(NSString *)auth contentType:(NSString *)contentType filename:(NSString *)filename image:(UIImage *)image {
    // 压缩图片，放线程中进行
    dispatch_queue_t queue = dispatch_queue_create("RequestUploadPhoto", NULL);
    dispatch_async(queue, ^(){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url ]];
        request.HTTPMethod = @"PUT";
        [request setValue:auth forHTTPHeaderField:@"Authorization"];
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        float compressionQuality = 0.9f;
        NSData *imageData;
        
        const static CGFloat kUploadAvatarMaxSize = 320;
        UIImage *squareImage = [UIImage imageWithCutImage:image moduleSize:CGSizeMake(kUploadAvatarMaxSize, kUploadAvatarMaxSize)];
        imageData = UIImageJPEGRepresentation(squareImage, compressionQuality);
        [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)imageData.length] forHTTPHeaderField:@"Content-Length"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session uploadTaskWithRequest:request
                               fromData:imageData
                      completionHandler:
          ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
              BOOL success = (!error && [data length] == 0);
              dispatch_async(dispatch_get_main_queue(), ^{
                  [self updateAvatarWith:squareImage success:success url:url];
              });
          }] resume];
    });
}

- (void)updateAvatarWith:(UIImage *)avatarImage success:(BOOL)success url:(NSString *)url {
    if (_uploadAvatarProgressHUD) {
        [_uploadAvatarProgressHUD removeFromSuperview];
        _uploadAvatarProgressHUD = nil;
    }
    if (!success) {
        return;
    }
    
#warning Eden
//    [MiaAPIHelper notifyAfterUploadPicWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
//        if (success) {
//            NSLog(@"notify after upload pic success");
//        } else {
//            NSLog(@"notify after upload pic failed:%@", userInfo[MiaAPIKey_Values][MiaAPIKey_Error]);
//        }
//    } timeoutBlock:^(MiaRequestItem *requestItem) {
//        NSLog(@"notify after upload pic timeout");
//    }];
    
    [_avatarImageView setImage:avatarImage];
    [HXUserSession session].user.avatarUrl = url;
    [[HXUserSession session] sysnc];
}

- (void)postNickNameChange:(NSString *)nick {
    if (!nick.length) {
        return;
    }
    if ([nick isEqualToString:_lastNickName]) {
        return;
    }
    
    [MiaAPIHelper changeNickName:nick completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [HXUserSession session].user.nickName = _nickNameTextField.text;
            [[HXUserSession session] sysnc];
            _lastNickName = _nickNameTextField.text;
            [HXAlertBanner showWithMessage:@"修改昵称成功" tap:nil];
        } else {
            id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [HXAlertBanner showWithMessage:[NSString stringWithFormat:@"%@", error] tap:nil];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [HXAlertBanner showWithMessage:@"修改昵称失败，网络请求超时" tap:nil];
    }];
}

- (void)updateGenderLabel:(MIAGender)gender {
    _lastGender = gender;
    
    switch (gender) {
        case MIAGenderMale: {
            [_genderLabel setText:@"男"];
            break;
        }
        case MIAGenderFemale: {
            [_genderLabel setText:@"女"];
            break;
        }
        default: {
            [_genderLabel setText:@"请选择"];
            break;
        }
    }
}

- (void)avatarTouchAction {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickerController.sourceType];
    }
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)nickNameTouchAction {
    [_nickNameTextField becomeFirstResponder];
}

- (void)genderTouchAction {
    GenderPickerView *pickerView = [[GenderPickerView alloc] initWithFrame:self.view.bounds];
    pickerView.gender = _lastGender;
    pickerView.delegate = self;
    [self.view addSubview:pickerView];
}

- (void)changePasswordTouchAction {
    ChangePwdViewController *changePwdViewController = [[ChangePwdViewController alloc] init];
    [self.navigationController pushViewController:changePwdViewController animated:YES];
}

- (void)cleanCacheTouchAction {
    MBProgressHUD *aMBProgressHUD = [MBProgressHUDHelp showLoadingWithText:@"正在清除缓存..."];
    [CacheHelper cleanCacheWithCompleteBlock:^{
        _cacheLabel.text = @"缓存已清除";
        [aMBProgressHUD removeFromSuperview];
        [HXAlertBanner showWithMessage:@"缓存清除成功" tap:nil];
    }];
}

- (void)feedbackTouchAction {
    HXFeedBackViewController *feedBackViewController = [HXFeedBackViewController instance];
    [self.navigationController pushViewController:feedBackViewController animated:YES];
}

- (void)versionTouchAction {
    const static long kClickTimesForUploadLog = 3;
    _uploadLogClickTimes++;
    if (_uploadLogClickTimes < kClickTimesForUploadLog) {
        return;
    }
    
    _uploadLogClickTimes = 0;
    [self postLastLog];
}

- (void)postLastLog {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [manager POST:@"http://applog.miamusic.com" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *act = [@"save" dataUsingEncoding:NSUTF8StringEncoding];
        NSData *key = [@"meweoids1122123**&" dataUsingEncoding:NSUTF8StringEncoding];
        NSData *platform = [@"iOS" dataUsingEncoding:NSUTF8StringEncoding];
        
        NSString *logTitle = [NSString stringWithFormat:@"%@\n%@ %@\n",
                              [UIDevice currentDevice].name,
                              [UIDevice currentDevice].systemName,
                              [UIDevice currentDevice].systemVersion];
        
        NSMutableData *content = [[NSMutableData alloc] init];
        [content appendData:[logTitle dataUsingEncoding:NSUTF8StringEncoding]];
        [content appendData:[[FileLog standard] latestLogs]];
        
        [formData appendPartWithFormData:act name:@"act"];
        [formData appendPartWithFormData:key name:@"key"];
        [formData appendPartWithFormData:platform name:@"platform"];
        [formData appendPartWithFormData:[content base64EncodedDataWithOptions:NSDataBase64Encoding64CharacterLineLength] name:@"content"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HXAlertBanner showWithMessage:@"喵~" tap:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HXAlertBanner showWithMessage:@"喵喵喵~" tap:nil];
    }];
}

- (void)logoutTouchAction {
    MBProgressHUD *aMBProgressHUD = [MBProgressHUDHelp showLoadingWithText:@"退出登录中..."];
    [MiaAPIHelper logoutWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [MiaAPIHelper guestLoginWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                if (success) {
                    NSLog(@"logout then sendUUID success");
                } else {
                    NSLog(@"logout then sendUUID failed:%@", userInfo[MiaAPIKey_Values][MiaAPIKey_Error]);
                }
            } timeoutBlock:^(MiaRequestItem *requestItem) {
                NSLog(@"logout then sendUUID timeout");
            }];
            
            [[HXUserSession session] logout];
            [HXAlertBanner showWithMessage:@"退出登录成功" tap:nil];
            [self shouldLogout];
			
#warning @andy 退出登录后应该跳回首页
            [self.navigationController popViewControllerAnimated:NO];
        } else {
            id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [HXAlertBanner showWithMessage:[NSString stringWithFormat:@"%@", error] tap:nil];
        }
        
        [aMBProgressHUD removeFromSuperview];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [aMBProgressHUD removeFromSuperview];
        [HXAlertBanner showWithMessage:@"退出登录失败，网络请求超时" tap:nil];
    }];
}

#pragma mark - Table View Delegate Methods
static CGFloat SectionSpace = 16.0f;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section ? 0.1f : SectionSpace;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SectionSpace;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_nickNameTextField resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HXSettingSection section = indexPath.section;
    switch (section) {
        case HXSettingSectionUser: {
            HXUserSectionRow row = indexPath.row;
            switch (row) {
                case HXUserSectionRowAvatar: {
                    [self avatarTouchAction];
                    break;
                }
                case HXUserSectionRowNickName: {
                    [self nickNameTouchAction];
                    break;
                }
                case HXUserSectionRowGender: {
                    [self genderTouchAction];
                    break;
                }
                case HXUserSectionRowPassWord: {
                    [self changePasswordTouchAction];
                    break;
                }
                case HXUserSectionRowMessageCenter: {
//                    HXMessageCenterViewController *messageCenterViewController = [HXMessageCenterViewController instance];
//                    [self.navigationController pushViewController:messageCenterViewController animated:YES];
                    break;
                }
            }
            break;
        }
        case HXSettingSectionAction: {
            HXActionSectionRow row = indexPath.row;
            switch (row) {
                case HXActionSectionRowNetwork: {
                    ;
                    break;
                }
                case HXActionSectionRowCache: {
                    [self cleanCacheTouchAction];
                    break;
                }
            }
            break;
        }
        case HXSettingSectionApp: {
            HXAppSectionRow row = indexPath.row;
            switch (row) {
                case HXAppSectionRowFeedBack: {
                    [self feedbackTouchAction];
                    break;
                }
                case HXAppSectionRowVersion: {
                    [self versionTouchAction];
                    break;
                }
            }
            break;
        }
        case HXSettingSectionLogout: {
            [self logoutTouchAction];
            break;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (_uploadAvatarProgressHUD) {
        NSLog(@"Last uploading is still running!!");
        return;
    }
    
    //获得编辑过的图片
    _uploadingImage = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    
    _uploadAvatarProgressHUD = [MBProgressHUDHelp showLoadingWithText:@"头像上传中..."];
    [MiaAPIHelper getUploadAvatarAuthWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSString *uploadUrl = userInfo[MiaAPIKey_Values][@"info"][@"url"];
            NSString *auth = userInfo[MiaAPIKey_Values][@"info"][@"auth"];
            NSString *contentType = userInfo[MiaAPIKey_Values][@"info"][@"ctype"];
            NSString *filename = userInfo[MiaAPIKey_Values][@"info"][@"fname"];
            
            [self uploadAvatarWithUrl:uploadUrl auth:auth contentType:contentType filename:filename image:_uploadingImage];
        } else {
            id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [HXAlertBanner showWithMessage:[NSString stringWithFormat:@"%@", error] tap:nil];
            [_uploadAvatarProgressHUD removeFromSuperview];
            _uploadAvatarProgressHUD = nil;
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [_uploadAvatarProgressHUD removeFromSuperview];
        _uploadAvatarProgressHUD = nil;
        [HXAlertBanner showWithMessage:@"上传头像失败，网络请求超时" tap:nil];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)genderPickerDidSelected:(MIAGender)gender {
    if (_lastGender == gender) {
        return;
    }
    
    [self updateGenderLabel:gender];
    
    [MiaAPIHelper changeGender:gender completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [HXAlertBanner showWithMessage:@"修改性别成功" tap:nil];
        } else {
            id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [HXAlertBanner showWithMessage:[NSString stringWithFormat:@"%@", error] tap:nil];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [HXAlertBanner showWithMessage:@"修改性别失败，网络请求超时" tap:nil];
    }];
}

#pragma mark - Text Field Delegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _nickNameTextField) {
        [textField resignFirstResponder];
    }
    
    return true;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self postNickNameChange:_nickNameTextField.text];
}

- (void)textFieldDidChange:(UITextField *)textField {
    const static int kNickNameMaxLength = 15;
    if (textField == _nickNameTextField) {
        if (textField.text.length > kNickNameMaxLength) {
            textField.text = [textField.text substringToIndex:kNickNameMaxLength];
        }
    }
}

@end
