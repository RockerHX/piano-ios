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
#import "LocationMgr.h"
#import "MBProgressHUD.h"
#import "MBProgressHUDHelp.h"
#import "UIImage+Extrude.h"

@interface HXPreviewLiveViewController () <
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
HXCountDownViewControllerDelegate,
HXPreviewLiveTopBarDelegate,
HXPreviewLiveEidtViewDelegate,
HXPreviewLiveControlViewDelegate
>
@end


@implementation HXPreviewLiveViewController {
    HXCountDownViewController *_countDownViewController;

	UIImage *_uploadingImage;
	MBProgressHUD *_uploadPictureProgressHUD;

    NSString *_roomID;
    NSString *_roomTitle;
    NSString *_shareUrl;
    BOOL _frontCamera;
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
    
    [_controlContainerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoard)]];
    
    [self showHUD];
    [MiaAPIHelper createRoomWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            NSDictionary *data = userInfo[MiaAPIKey_Values][MiaAPIKey_Data];
            self->_roomID = data[@"roomID"];
            self->_shareUrl = data[@"shareUrl"];
        }
        [self hiddenHUD];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self hiddenHUD];
        [self showBannerWithPrompt:TimtOutPrompt];
    }];
}

- (void)viewConfigure {
    [self startPreview];
    [self startUpdatingLocation];
}

#pragma mark - Private Methods
- (void)startPreview {
    [[HXZegoAVKitManager manager].zegoAVApi setFrontCam:_frontCamera];
    
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    [zegoAVApi setAVConfig:[HXSettingSession session].configure];
    [zegoAVApi setLocalView:_preview];
    [zegoAVApi setLocalViewMode:ZegoVideoViewModeScaleAspectFill];
    [zegoAVApi startPreview];
}

- (void)stopPreview {
    ZegoAVApi *zegoAVApi = [HXZegoAVKitManager manager].zegoAVApi;
    [zegoAVApi stopPreview];
    [zegoAVApi setLocalView:nil];
}

- (void)startUpdatingLocation {
	[[LocationMgr standard] initLocationMgr];
    [[LocationMgr standard] startUpdatingLocationWithOnceBlock:^(CLLocationCoordinate2D coordinate, NSString *address) {
        if (address.length) {
            _editView.locationLabel.text = address;
        }
    }];
}

- (void)startCountDown {
    _countDownContainerView.hidden = NO;
    [_countDownViewController startCountDown];
}

- (void)setRoomTitle {
    [self showHUD];
    
    _roomTitle = _editView.textField.text;
    
    if (_roomTitle.length) {
        [MiaAPIHelper setRoomTitle:_roomTitle
                            roomID:_roomID
                     completeBlock:
         ^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
             if (success) {
                 self.controlContainerView.hidden = YES;
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

- (void)coverTouchAction {
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
		imagePickerController.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
		imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePickerController.sourceType];
	}
	imagePickerController.delegate = self;
	imagePickerController.allowsEditing = YES;
	[self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - HXCountDownViewControllerDelegate Methods
- (void)countDownFinished {
    _countDownContainerView.hidden = YES;
    
    [_countDownContainerView removeFromSuperview];
    _countDownContainerView = nil;
    
    if (_delegate && [_delegate respondsToSelector:@selector(previewControllerHandleFinishedShouldStartLive:roomID:roomTitle:shareUrl:frontCamera:)]) {
        [_delegate previewControllerHandleFinishedShouldStartLive:self roomID:_roomID roomTitle:_roomTitle shareUrl:_shareUrl frontCamera:_frontCamera];
    }
}

#pragma mark - HXPreviewLiveTopBarDelegate Methods
- (void)topBar:(HXPreviewLiveTopBar *)bar takeAction:(HXPreviewLiveTopBarAction)action {
    switch (action) {
        case HXPreviewLiveTopBarActionBeauty: {
            ;
            break;
        }
        case HXPreviewLiveTopBarActionChange: {
            _frontCamera = !_frontCamera;
            [[HXZegoAVKitManager manager].zegoAVApi setFrontCam:_frontCamera];
            break;
        }
        case HXPreviewLiveTopBarActionColse: {
            [self stopPreview];
            [self dismissViewControllerAnimated:YES completion:nil];
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
        case HXPreviewLiveEidtViewActionCamera: {
			[self coverTouchAction];
            break;
        }
        case HXPreviewLiveEidtViewActionLocation: {
            _editView.locationView.hidden = YES;
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

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissViewControllerAnimated:YES completion:nil];
	if (_uploadPictureProgressHUD) {
		NSLog(@"Last uploading is still running!!");
		return;
	}

	//获得编辑过的图片
	_uploadingImage = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    
	_uploadPictureProgressHUD = [MBProgressHUDHelp showLoadingWithText:@"直播封面上传中..."];
	[MiaAPIHelper getUploadAuthWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
		if (success) {
			NSString *uploadUrl = userInfo[MiaAPIKey_Values][@"data"][@"url"];
			NSString *auth = userInfo[MiaAPIKey_Values][@"data"][@"auth"];
			NSString *contentType = userInfo[MiaAPIKey_Values][@"data"][@"ctype"];
			NSString *filename = userInfo[MiaAPIKey_Values][@"data"][@"fname"];
			NSString *fileID = [NSString stringWithFormat:@"%@", userInfo[MiaAPIKey_Values][@"data"][@"fileID"]];

			[self uploadPictureWithUrl:uploadUrl
								 auth:auth
						  contentType:contentType
							 filename:filename
							   fileID:fileID
								image:_uploadingImage];
		} else {
			id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [self showBannerWithPrompt:[NSString stringWithFormat:@"%@", error]];
			[_uploadPictureProgressHUD removeFromSuperview];
			_uploadPictureProgressHUD = nil;
		}
	} timeoutBlock:^(MiaRequestItem *requestItem) {
		[_uploadPictureProgressHUD removeFromSuperview];
        _uploadPictureProgressHUD = nil;
        [self showBannerWithPrompt:@"上传直播封面失败，网络请求超时"];
	}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadPictureWithUrl:(NSString *)url
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

		const static CGFloat kImageMaxSize = 320;
		UIImage *squareImage = [UIImage imageWithCutImage:image moduleSize:CGSizeMake(kImageMaxSize, kImageMaxSize)];
		imageData = UIImageJPEGRepresentation(squareImage, compressionQuality);
		[request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)imageData.length] forHTTPHeaderField:@"Content-Length"];

		NSURLSession *session = [NSURLSession sharedSession];
		[[session uploadTaskWithRequest:request
							   fromData:imageData
					  completionHandler:
		  ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
			  BOOL success = (!error && [data length] == 0);
			  dispatch_async(dispatch_get_main_queue(), ^{
				  [self updatePictureWith:squareImage success:success url:url fileID:fileID];
			  });
		  }] resume];
	});
}

- (void)updatePictureWith:(UIImage *)image success:(BOOL)success url:(NSString *)url fileID:(NSString *)fileID {
	if (_uploadPictureProgressHUD) {
		[_uploadPictureProgressHUD removeFromSuperview];
		_uploadPictureProgressHUD = nil;
	}
	if (!success) {
		return;
	}

	[MiaAPIHelper setRoomCover:fileID roomID:_roomID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
		if (success) {
            NSLog(@"notify after upload pic success");
            UIImage *squareImage = [UIImage imageWithCutImage:image moduleSize:CGSizeMake(11.0f, 11.0f)];
            [_editView updateCameraIconWithImage:squareImage];
		} else {
			NSLog(@"notify after upload pic failed:%@", userInfo[MiaAPIKey_Values][MiaAPIKey_Error]);
		}
	} timeoutBlock:^(MiaRequestItem *requestItem) {
		NSLog(@"notify after upload pic timeout");
	}];
}

@end
