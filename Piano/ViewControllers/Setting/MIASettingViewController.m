//
//  MIASettingViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASettingViewController.h"
#import "MIASettingContentViewController.h"
#import "HXFeedBackViewController.h"
#import "ChangePwdViewController.h"
#import "MBProgressHUDHelp.h"
#import "HXAlertBanner.h"
#import "MIANavBarView.h"
#import "MIASettingViewModel.h"
#import "UIImageView+WebCache.h"
#import "HXUserSession.h"
#import "UserSetting.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"
#import "NSObject+LoginAction.h"
#import "UIImage+Extrude.h"
#import "CacheHelper.h"
#import "FXBlurView.h"
#import "MIACellManage.h"

static CGFloat const kSettingNavBarHeight = 50.;//Bar的高度

@interface MIASettingViewController()<UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) MIANavBarView *navBarView;

@property (nonatomic, strong) UITableView *settingTableView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UISwitch *netSwitch;

@property (nonatomic, strong) MIASettingViewModel *settingViewModel;

@property (nonatomic, strong) UIImage *uploadingImage;
@property (nonatomic, strong) MBProgressHUD *uploadAvatarProgressHUD;

@property (nonatomic, copy) SettingDataChangeBlock settingDataChangeBlock;

@end

@implementation MIASettingViewController

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self loadViewModel];
    
    [self createCoverImageView];
    [self createNavBarView];
    [self createHeadImageView];
    [self createNetSwitch];
    [self createSettingTableView];
}

- (void)createCoverImageView{
    
    self.coverImageView = [UIImageView newAutoLayoutView];
    [_coverImageView setImage:[_maskImage blurredImageWithRadius:6.0f iterations:5 tintColor:[UIColor blackColor]]];
    [self.view addSubview:_coverImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_coverImageView superView:self.view];
    
    UIImageView *maskImageView = [UIImageView newAutoLayoutView];
    [maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [self.view addSubview:maskImageView];
    
    [JOAutoLayout autoLayoutWithSameView:_coverImageView selfView:maskImageView superView:self.view];
}

- (void)createNavBarView{

    self.navBarView = [MIANavBarView newAutoLayoutView];
    [_navBarView setTitle:@"设置"];
    [_navBarView setBackgroundColor:JORGBCreate(0., 0., 0., 0.5)];
    [[_navBarView navBarTitleLabel] setTextColor:[UIColor whiteColor]];
//    [_navBarView setLeftButtonTitle:@"x" titleColor:[UIColor whiteColor]];
    [_navBarView setLeftButtonImageName:@"C-BackIcon-White"];
    
    @weakify(self);
    [_navBarView navBarLeftClickHanlder:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightClickHandler:nil];
    [self.view addSubview:_navBarView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kSettingNavBarHeight selfView:_navBarView superView:self.view];
}

- (void)createSettingTableView{

    self.settingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_settingTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_settingTableView setDataSource:self];
    [_settingTableView setDelegate:self];
    [_settingTableView setBackgroundColor:[UIColor clearColor]];
    [_settingTableView setSectionHeaderHeight:CGFLOAT_MIN];
//    [_settingTableView setSeparatorColor:JORGBCreate(80., 80., 80., 0.0)];
    [_settingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_settingTableView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_settingTableView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kSettingNavBarHeight selfView:_settingTableView superView:self.view];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_settingTableView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_settingTableView superView:self.view];
}

- (void)createHeadImageView{

    self.headImageView = [UIImageView newAutoLayoutView];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl]
                      placeholderImage:[UIImage imageNamed:@"C-AvatarDefaultIcon"]];
    [[_headImageView layer] setCornerRadius:kSettingHeadImageHeight/2.];
    [[_headImageView layer] setMasksToBounds:YES];
}

- (void)createNetSwitch{

    self.netSwitch = [UISwitch newAutoLayoutView];
    [_netSwitch setOn:[UserSetting playWith3G]];
    [_netSwitch addTarget:self action:@selector(changeNetSwitchState:) forControlEvents:UIControlEventValueChanged];
}

- (void)loadViewModel{

    self.settingViewModel = [MIASettingViewModel new];
    
    @weakify(self);
    [_settingViewModel contentDataUpdateHanlder:^{
    @strongify(self);
        [self.settingTableView reloadData];
    }];
}

#pragma mark - action

- (void)changeNetSwitchState:(id)sender{

    UISwitch *netSwtich = (UISwitch *)sender;
    [UserSetting setPlayWith3G:netSwtich.on];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return [_settingViewModel.settingCellDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_settingViewModel.settingCellDataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [MIACellManage getCellWithType:MIACellTypeSetting];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString *contentString = @"";
    if (indexPath.section == 0 && indexPath.row == 0) {
    }else{
        
        if (indexPath.section == 0 && indexPath.row == 3) {
            
            NSString *genderString = [[_settingViewModel.settingCellContentDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if ([genderString isEqualToString:@"1"]) {
                contentString = @"男";
            }else if ([genderString isEqualToString:@"2"]){
                contentString = @"女";
            }
            
        }else{
            
            contentString = [[_settingViewModel.settingCellContentDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//            [[cell detailTextLabel] setText:[[_settingViewModel.settingCellContentDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        }
    }
    
    [(MIASettingCell *)cell setSettingCellTitle:[[_settingViewModel.settingCellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] contnet:contentString];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0 && row == 0) {
        //头像
        [cell.contentView addSubview:_headImageView];
        
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-17. selfView:_headImageView superView:cell.contentView];
        [JOAutoLayout autoLayoutWithSize:JOSize(kSettingHeadImageHeight, kSettingHeadImageHeight) selfView:_headImageView superView:cell.contentView];
        [JOAutoLayout autoLayoutWithCenterYWithView:cell.contentView selfView:_headImageView superView:cell.contentView];
    }
    
    if (section == 1 && row == 2) {
        //网络开关
        [cell.contentView addSubview:_netSwitch];
        
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-15. selfView:_netSwitch superView:cell.contentView];
        [JOAutoLayout autoLayoutWithCenterYWithView:cell.contentView selfView:_netSwitch superView:cell.contentView];
        [JOAutoLayout autoLayoutWithSize:JOSize(44, 26.) selfView:_netSwitch superView:cell.contentView];
    }
    
    //是否存在箭头指示
    if ((section == 0 && row == 0) || (section == 1) || (section == 2 && row == 1) || (section == 2 && row == 2)) {
        //不存在箭头指示
        [(MIASettingCell *)cell setCellAccessoryImage:nil];
    }else{
        [(MIASettingCell *)cell setCellAccessoryImage:[UIImage imageNamed:@"C-ArrowIcon-Right-Gray"]];
//        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"0_cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
//    [cell setBackgroundColor:JORGBCreate(0., 0., 0., 0.4)];
//    [[cell contentView] setBackgroundColor:JORGBCreate(0., 0., 0., 0.4)];
    [[cell textLabel] setTextColor:[MIAFontManage getFontWithType:MIAFontType_Setting_CellTitle]->color];
    [[cell textLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Setting_CellTitle]->font];
//    NSLog(@"fontName:%@",[[cell textLabel] font]);
    [[cell textLabel] setText:[[_settingViewModel.settingCellDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    [[cell detailTextLabel] setTextColor:[MIAFontManage getFontWithType:MIAFontType_Setting_CellContent]->color];
    [[cell detailTextLabel] setFont:[MIAFontManage getFontWithType:MIAFontType_Setting_CellContent]->font];
    if (indexPath.section == 0 && indexPath.row == 0) {
    }else{
        
        if (indexPath.section == 0 && indexPath.row == 3) {
            
            NSString *genderString = [[_settingViewModel.settingCellContentDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
            if ([genderString isEqualToString:@"1"]) {
                [[cell detailTextLabel] setText:@"男"];
            }else if ([genderString isEqualToString:@"2"]){
                [[cell detailTextLabel] setText:@"女"];
            }
            
        }else{
            [[cell detailTextLabel] setText:[[_settingViewModel.settingCellContentDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        }
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0 && row == 0) {
        //头像
        [cell.contentView addSubview:_headImageView];
        
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-17. selfView:_headImageView superView:cell.contentView];
        [JOAutoLayout autoLayoutWithSize:JOSize(kSettingHeadImageHeight, kSettingHeadImageHeight) selfView:_headImageView superView:cell.contentView];
        [JOAutoLayout autoLayoutWithCenterYWithView:cell.contentView selfView:_headImageView superView:cell.contentView];
    }
    
    if (section == 1 && row == 2) {
        //网络开关
        [cell.contentView addSubview:_netSwitch];
        
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-15. selfView:_netSwitch superView:cell.contentView];
        [JOAutoLayout autoLayoutWithCenterYWithView:cell.contentView selfView:_netSwitch superView:cell.contentView];
        [JOAutoLayout autoLayoutWithSize:JOSize(44, 26.) selfView:_netSwitch superView:cell.contentView];
    }
    
    //是否存在箭头指示
    if ((section == 0 && row == 0) || (section == 1) || (section == 2 && row == 1) || (section == 2 && row == 2)) {
        //不存在箭头指示
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }else{
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    */
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        //头像
        return kSettingHeadImageCellHeight;
    }else{
    
        return kSettingDefaultCellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 11.;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (section == 0) {
        
        if (row == 0) {
            //修改头像
            [self changeHeadImage];
        }else if (row == 1){
            //修改昵称
            [self changeNickName];
        }else if (row == 2){
            //签名
            [self changeSummay];
        }else if (row == 3){
            //性别
            [self changeGender];
        }else if (row == 4){
            //修改密码
            [self changePassword];
        }
        
    }else if (section == 1){
        
         if (row == 0){
            //清除缓存
            [self cleanCache];
         }else if (row == 1) {
             //网络播放
             [self cleanSongCache];
         }else if (row == 2){
            //清除下载的歌曲
            
        }
    }else if (section == 2){
    
        if (row == 0) {
            //意见反馈
            [self feedback];
        }else if (row == 1){
            //当前版本
            
        }else if (row == 2){
            //退出登录
            [self logout];
        }
    }
    
}

#pragma mark - block

- (void)settingDataChangeHandler:(SettingDataChangeBlock)block{

    self.settingDataChangeBlock = nil;
    self.settingDataChangeBlock = block;
}

#pragma mark - Action

- (void)changeHeadImage{

    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        imagePickerController.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickerController.sourceType];
    }
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)changeNickName{

    MIASettingContentViewController *settingContentViewController = [[MIASettingContentViewController alloc] initWithContentType:SettingContentType_Nick];
    [settingContentViewController setSettingContent:[HXUserSession session].user.nickName];
    @weakify(self);
    [settingContentViewController settingContentSaveHandler:^(SettingContentType contentType, NSString *content) {
    @strongify(self);
        [self.settingViewModel updateNickName:content];
        
        if (self.settingDataChangeBlock) {
            self.settingDataChangeBlock();
        }
        
    }];
    [self.navigationController pushViewController:settingContentViewController animated:YES];
}

- (void)changeSummay{

    MIASettingContentViewController *settingContentViewController = [[MIASettingContentViewController alloc] initWithContentType:SettingContentType_Summary];
    [settingContentViewController setSettingContent:[HXUserSession session].user.bio];
    @weakify(self);
    [settingContentViewController settingContentSaveHandler:^(SettingContentType contentType, NSString *content) {
    @strongify(self);
        [self.settingViewModel updateSummay:content];
        
        if (self.settingDataChangeBlock) {
            self.settingDataChangeBlock();
        }
    }];
    [self.navigationController pushViewController:settingContentViewController animated:YES];
}

- (void)changeGender{

    MIASettingContentViewController *settingContentViewController = [[MIASettingContentViewController alloc] initWithContentType:SettingContentType_Gender];
    if ([[HXUserSession session].user.gender isEqualToString:@"1"]) {
        [settingContentViewController setGenderType:GenderMale];
    }else if([[HXUserSession session].user.gender isEqualToString:@"2"]){
        [settingContentViewController setGenderType:GenderFemale];
    }
    @weakify(self);
    [settingContentViewController settingContentSaveHandler:^(SettingContentType contentType, NSString *content) {
    @strongify(self);
        [self.settingViewModel updateGender:content];
    }];
    [self.navigationController pushViewController:settingContentViewController animated:YES];
}

- (void)changePassword{

    ChangePwdViewController *changePwdViewController = [[ChangePwdViewController alloc] init];
    [self.navigationController pushViewController:changePwdViewController animated:YES];
}

- (void)cleanCache{

    MBProgressHUD *aMBProgressHUD = [MBProgressHUDHelp showLoadingWithText:@"正在清除缓存..."];
    [CacheHelper cleanCacheWithCompleteBlock:^{
//        _cacheLabel.text = @"缓存已清除";
        [aMBProgressHUD removeFromSuperview];
        [HXAlertBanner showWithMessage:@"缓存清除成功" tap:nil];
        [_settingViewModel updateCache];
    }];
}

- (void)cleanSongCache{

    MBProgressHUD *aMBProgressHUD = [MBProgressHUDHelp showLoadingWithText:@"正在清除缓存歌曲..."];
    [CacheHelper cleanSongCacheWithCompleteBlock:^{
        //        _cacheLabel.text = @"缓存已清除";
        [aMBProgressHUD removeFromSuperview];
        [HXAlertBanner showWithMessage:@"缓存歌曲清除成功" tap:nil];
        [_settingViewModel updateSongCache];
    }];
}

- (void)feedback{

//    HXFeedBackViewController *feedBackViewController = [HXFeedBackViewController instance];
//    [self.navigationController pushViewController:feedBackViewController animated:YES];
    
    MIASettingContentViewController *settingContentViewController = [[MIASettingContentViewController alloc] initWithContentType:SettingContentType_Feedback];
    [self.navigationController pushViewController:settingContentViewController animated:YES];
}

- (void)logout{
    
    [self showAlertWithMessage:@"确定退出当前账号?" otherTitle:@"取消" handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) {
            
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
                    
                    [self.navigationController popToRootViewControllerAnimated:NO];
                    
                    [self.navigationController dismissViewControllerAnimated:NO completion:^{
                    }];
                    [self shouldLogout];
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
    }];
}

- (void)logoutAction{

   
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
    [MiaAPIHelper getUploadAuthWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSString *uploadUrl = userInfo[MiaAPIKey_Values][@"data"][@"url"];
            NSString *auth = userInfo[MiaAPIKey_Values][@"data"][@"auth"];
            NSString *contentType = userInfo[MiaAPIKey_Values][@"data"][@"ctype"];
            NSString *filename = userInfo[MiaAPIKey_Values][@"data"][@"fname"];
            NSString *fileID = [NSString stringWithFormat:@"%@", userInfo[MiaAPIKey_Values][@"data"][@"fileID"]];
            
            [self uploadAvatarWithUrl:uploadUrl
                                 auth:auth
                          contentType:contentType
                             filename:filename
                               fileID:fileID
                                image:_uploadingImage];
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

#pragma mark - Private Methods
- (void)uploadAvatarWithUrl:(NSString *)url
                       auth:(NSString *)auth
                contentType:(NSString *)contentType
                   filename:(NSString *)filename
                     fileID:(NSString *)fileID
                      image:(UIImage *)image {
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
                  [self updateAvatarWith:squareImage success:success url:url fileID:fileID];
              });
          }] resume];
    });
}

- (void)updateAvatarWith:(UIImage *)avatarImage success:(BOOL)success url:(NSString *)url fileID:(NSString *)fileID {
    if (_uploadAvatarProgressHUD) {
        [_uploadAvatarProgressHUD removeFromSuperview];
        _uploadAvatarProgressHUD = nil;
    }
    if (!success) {
        return;
    }
    
    [MiaAPIHelper uploadFinishWithFileID:fileID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSLog(@"notify after upload pic success");
        } else {
            NSLog(@"notify after upload pic failed:%@", userInfo[MiaAPIKey_Values][MiaAPIKey_Error]);
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        NSLog(@"notify after upload pic timeout");
    }];
    
    [_headImageView setImage:avatarImage];
    [_settingViewModel updateAvtarURLString:url];
    if (self.settingDataChangeBlock) {
        self.settingDataChangeBlock();
    }
}

@end
