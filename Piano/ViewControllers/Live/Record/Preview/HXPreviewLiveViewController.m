//
//  HXPreviewLiveViewController.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPreviewLiveViewController.h"
#import "HXCountDownViewController.h"
#import "HXZegoAVKitManager.h"
#import "HXSettingSession.h"
#import "HXPreviewLiveTopBar.h"
#import "HXPreviewLiveEidtView.h"
#import "HXPreviewLiveControlView.h"
#import "MiaAPIHelper.h"
#import "MBProgressHUD.h"
#import "MBProgressHUDHelp.h"
#import "UIImage+Extrude.h"
#import "HXSelectedAlbumViewController.h"
#import "HXAlbumModel.h"
#import "UIImageView+WebCache.h"
#import "HXLiveModel.h"

@interface HXPreviewLiveViewController () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
HXCountDownViewControllerDelegate,
HXPreviewLiveTopBarDelegate,
HXPreviewLiveEidtViewDelegate,
HXPreviewLiveControlViewDelegate,
HXSelectedAlbumViewControllerDelegate
>
@end


@implementation HXPreviewLiveViewController {
    HXCountDownViewController *_countDownViewController;

	UIImage *_uploadingImage;
	MBProgressHUD *_uploadPictureProgressHUD;

    HXLiveModel *_model;
    BOOL _frontCamera;
    BOOL _beauty;
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _countDownViewController = segue.destinationViewController;
    _countDownViewController.delegate = self;
}

#pragma mark - Status Bar
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _frontCamera = YES;
	_beauty = YES;
    _model = [HXLiveModel new];
    
    [_controlContainerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)]];
    
    [self showHUD];
    [MiaAPIHelper createRoomWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            _model.roomID = data[@"roomID"];
            _model.shareUrl = data[@"shareUrl"];
        }
        [self hiddenHUD];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self hiddenHUD];
        [self showBannerWithPrompt:TimtOutPrompt];
    }];
}

- (void)viewConfigure {
    ;
}

#pragma mark - Private Methods
- (void)startCountDown {
    self.controlContainerView.hidden = YES;
    _countDownContainerView.hidden = NO;
    [_countDownViewController startCountDown];
}

- (void)setRoomTitle {
    [self showHUD];
    
    _model.title = _editView.textField.text;
    
    if (_model.title.length) {
        [MiaAPIHelper setRoomTitle:_model.title
                            roomID:_model.roomID
                     completeBlock:
         ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
             if (success) {
                 NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
                 _model.shareTitle = data[@"shareTitle"];
                 _model.shareContent = data[@"shareContent"];
                 [self startCountDown];
             }
             [self hiddenHUD];
         } timeoutBlock:^(MiaRequestItem *requestItem) {
             [self hiddenHUD];
             [self showBannerWithPrompt:TimtOutPrompt];
         }];
    } else {
        [self hiddenHUD];
        [self showBannerWithPrompt:@"请先填写直播标题！"];
    }
}

- (void)closeKeyBoard {
    [self.view endEditing:YES];
}

#pragma mark - HXCountDownViewControllerDelegate Methods
- (void)countDownFinished {
    _countDownContainerView.hidden = YES;
    
    [_countDownContainerView removeFromSuperview];
    _countDownContainerView = nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(previewControllerHandleFinishedShouldStartLive:liveModel:frontCamera:beauty:)]) {
        [_delegate previewControllerHandleFinishedShouldStartLive:self liveModel:_model frontCamera:_frontCamera beauty:_beauty];
    }
}

#pragma mark - HXPreviewLiveTopBarDelegate Methods
- (void)topBar:(HXPreviewLiveTopBar *)bar takeAction:(HXPreviewLiveTopBarAction)action {
    ZegoLiveApi *zegoLiveApi = [HXZegoAVKitManager manager].zegoLiveApi;
    switch (action) {
        case HXPreviewLiveTopBarActionBeauty: {
            _beauty = !_beauty;
			[zegoLiveApi enableBeautifying:_beauty ? ZEGO_BEAUTIFY_POLISH : ZEGO_BEAUTIFY_NONE];
            break;
        }
        case HXPreviewLiveTopBarActionChange: {
            _frontCamera = !_frontCamera;
            [zegoLiveApi setFrontCam:_frontCamera];
            break;
        }
        case HXPreviewLiveTopBarActionColse: {
            if (_delegate && [_delegate respondsToSelector:@selector(previewControllerClosed:)]) {
                [_delegate previewControllerClosed:self];
            }
            break;
        }
    }
}

#pragma marrk - HXPreviewLiveEidtViewDelegate Methods
- (void)editView:(HXPreviewLiveEidtView *)editView takeAction:(HXPreviewLiveEidtViewAction)action {
    switch (action) {
        case HXPreviewLiveEidtViewActionEdit: {
            ;
            break;
        }
        case HXPreviewLiveEidtViewActionAddAlbum: {
            HXSelectedAlbumViewController *selctedAlbumViewController = [HXSelectedAlbumViewController instance];
            selctedAlbumViewController.delegate = self;
            [self presentViewController:selctedAlbumViewController animated:YES completion:nil];
            break;
        }
        case HXPreviewLiveEidtViewActionClear: {
            _model.album = nil;
            break;
        }
    }
}

#pragma mark - HXPreviewLiveControlViewDelegate Methods
- (void)controlView:(HXPreviewLiveControlView *)controlView takeAction:(HXPreviewLiveControlViewAction)action {
    switch (action) {
        case HXPreviewLiveControlViewActionFriendsCycle: {
            ;
            break;
        }
        case HXPreviewLiveControlViewActionWeChat: {
            ;
            break;
        }
        case HXPreviewLiveControlViewActionWeiBo: {
            ;
            break;
        }
        case HXPreviewLiveControlViewActionStartLive: {
            [self.view endEditing:YES];
            [self setRoomTitle];
            break;
        }
    }
}

#pragma mark - HXSelectedAlbumViewControllerDelegate Methods
- (void)selectedAlbumViewController:(HXSelectedAlbumViewController *)viewController selectedAlbum:(HXAlbumModel *)album {
    _editView.addAlbumButton.hidden = YES;
    _editView.albumNameLabel.hidden = NO;
    _editView.albumContainer.hidden = NO;
    _editView.albumNameLabel.text = album.title;
    [_editView.albumCoverView sd_setImageWithURL:[NSURL URLWithString:album.coverUrl]];
    
    [self showHUD];
    [MiaAPIHelper liveRelatedAlbum:album.ID roomID:_model.roomID completeBlock:
     ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
         [self hiddenHUD];
         if (success) {
             _model.album = album;
         } else {
             _editView.albumCoverView.image = nil;
         }
     } timeoutBlock:^(MiaRequestItem *requestItem) {
         [self hiddenHUD];
         _editView.albumCoverView.image = nil;
    }];
}

@end
