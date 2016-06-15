//
//  HXDiscoveryViewController.m
//  Piano
//
//  Created by miaios on 16/3/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryViewController.h"
#import "HXDiscoveryContainerViewController.h"
#import "HXRecordLiveViewController.h"
#import "HXWatchLiveLandscapeViewController.h"
#import "HXWatchLiveLandscapeViewController.h"
#import "HXPlayViewController.h"
#import "HXUserSession.h"
#import "HXAlbumsViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MusicMgr.h"
#import "HXDiscoveryTopBar.h"
#import "HXDiscoveryViewModel.h"
#import "UIImageView+WebCache.h"
#import "FXBlurView.h"
#import "MIAProfileViewController.h"
#import "HXHostProfileViewController.h"
#import "MIAHostProfileViewController.h"
#import "UIButton+WebCache.h"
#import "MiaAPIHelper.h"
#import "HXLiveModel.h"
#import "BFRadialWaveHUD.h"


@interface HXDiscoveryViewController () <
HXDiscoveryTopBarDelegate,
HXDiscoveryContainerDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>
@end


@implementation HXDiscoveryViewController {
    HXDiscoveryContainerViewController *_containerViewController;
    
    HXDiscoveryViewModel *_viewModel;
    
    NSInteger _itemCount;
    BFRadialWaveHUD *_hud;
}

#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _containerViewController = segue.destinationViewController;
    _containerViewController.delegate = self;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    MusicMgr *musicMgr = [MusicMgr standard];
    _topBar.playerEntry.hidden = !(musicMgr.playList.count && musicMgr.isPlaying);
    [_topBar.profileButton sd_setImageWithURL:[NSURL URLWithString:[HXUserSession session].user.avatarUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"D-ProfileEntryIcon"]];
    [_containerViewController reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    [self showLoadingHUD];
    
    _itemCount = 20;
    
    _viewModel = [[HXDiscoveryViewModel alloc] init];
    _containerViewController.viewModel = _viewModel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startFetchList) name:UIApplicationDidBecomeActiveNotification object:nil];
}
 
- (void)viewConfigure {
    ;
}

#pragma mark - Public Methods
- (void)startFetchList {
    @weakify(self)
    RACSignal *requestSiganl = [_viewModel.fetchCommand execute:nil];
    [requestSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
        [self showErrorLoading];
    } completed:^{
        @strongify(self)
        [self fetchCompleted];
    }];
}

- (void)recoveryLive {
    [self hiddenNavigationBar];
    
    [MiaAPIHelper refetchLiveWithCompleteBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            HXLiveModel *model = [HXLiveModel mj_objectWithKeyValues:userInfo[MiaAPIKey_Values][MiaAPIKey_Data]];
            HXRecordLiveViewController *recordLiveViewController = [HXRecordLiveViewController instance];
            [recordLiveViewController recoveryLive:model];
            [self presentViewController:recordLiveViewController animated:YES completion:nil];
        }
    } timeoutBlock:nil];
}

#pragma mark - Private Methods
- (void)showLoadingHUD {
    if (!_hud) {
        _hud = [[BFRadialWaveHUD alloc] initWithView:self.view
                                          fullScreen:YES
                                             circles:BFRadialWaveHUD_DefaultNumberOfCircles
                                         circleColor:nil
                                                mode:BFRadialWaveHUDMode_Default
                                         strokeWidth:BFRadialWaveHUD_DefaultCircleStrokeWidth];
        [_hud setBlurBackground:YES];
    }
    [_hud show];
}

- (void)showErrorLoading {
    [_hud showErrorWithCompletion:^(BOOL finished) {
        [_hud dismiss];
    }];
}

- (void)hiddenLoadingHUD {
    [_hud dismissAfterDelay:0.5f];
}

- (void)fetchCompleted {
    [_containerViewController displayDiscoveryList];
    [self showCoverWithCoverUrl:[_viewModel.discoveryList firstObject].coverUrl];
    [self hiddenLoadingHUD];
}

- (void)showCoverWithCoverUrl:(NSString *)coverUrl {
    __weak __typeof__(self)weakSelf = self;
    [_coverView sd_setImageWithURL:[NSURL URLWithString:coverUrl] completed:
     ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         __strong __typeof__(self)strongSelf = weakSelf;
         strongSelf.coverView.image = [image blurredImageWithRadius:20.0f iterations:10 tintColor:[UIColor blackColor]];
     }];
}

- (void)hiddenNavigationBar {
    if (_delegate && [_delegate respondsToSelector:@selector(discoveryViewController:takeAction:)]) {
        [_delegate discoveryViewController:self takeAction:HXDiscoveryViewControllerActionHiddenNavigationBar];
    }
}

- (void)pauseMusic {
    MusicMgr *musicMgr = [MusicMgr standard];
    if (musicMgr.isPlaying) {
        [[MusicMgr standard] pause];
    }
}

- (void)uploadCoverImage:(UIImage *)image {
    [self showHUD];
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
                                image:image];
        } else {
            [self hiddenHUD];
            id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [self showBannerWithPrompt:[NSString stringWithFormat:@"%@", error]];
        }
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self hiddenHUD];
        [self showBannerWithPrompt:@"上传失败，网络请求超时"];
    }];
}

- (void)uploadAvatarWithUrl:(NSString *)url auth:(NSString *)auth contentType:(NSString *)contentType filename:(NSString *)filename fileID:(NSString *)fileID image:(UIImage *)image {
    // 压缩图片，放线程中进行
    dispatch_queue_t queue = dispatch_queue_create("RequestUploadPhoto", NULL);
    dispatch_async(queue, ^(){
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url ]];
        request.HTTPMethod = @"PUT";
        [request setValue:auth forHTTPHeaderField:@"Authorization"];
        [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.9f);
        [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)imageData.length] forHTTPHeaderField:@"Content-Length"];
        
        NSURLSession *session = [NSURLSession sharedSession];
        [[session uploadTaskWithRequest:request
                               fromData:imageData
                      completionHandler:
          ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
              BOOL success = (!error && [data length] == 0);
              dispatch_async(dispatch_get_main_queue(), ^{
                  if (success) {
                      [self setCoverImage:[UIImage imageWithData:imageData] coverID:fileID coverUrl:url];
                  } else {
                      [self hiddenHUD];
                      [self showBannerWithPrompt:@"上传失败，网络请求超时"];
                  }
              });
          }] resume];
    });
}

- (void)setCoverImage:(UIImage *)image coverID:(NSString *)coverID coverUrl:(NSString *)coverUrl {
    [MiaAPIHelper setRoomCover:coverID completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        if (success) {
            [self showBannerWithPrompt:@"设置成功"];
            
            [HXUserSession session].user.coverUrl = coverUrl;
            [_viewModel.discoveryList firstObject].coverUrl = coverUrl;
            [_containerViewController reload];
        } else {
            id error = userInfo[MiaAPIKey_Values][MiaAPIKey_Error];
            [self showBannerWithPrompt:[NSString stringWithFormat:@"%@", error]];
        }
        [self hiddenHUD];
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        [self hiddenHUD];
        [self showBannerWithPrompt:@"设置失败，网络请求超时"];
    }];
}

#pragma mark - HXDiscoveryTopBarDelegate
- (void)topBar:(HXDiscoveryTopBar *)bar takeAction:(HXDiscoveryTopBarAction)action {
    [self hiddenNavigationBar];
    switch (action) {
        case HXDiscoveryTopBarActionProfile: {
            
            MIAHostProfileViewController *hostProfileViewController = [MIAHostProfileViewController new];
            [self.navigationController pushViewController:hostProfileViewController animated:YES];
//            [self.navigationController pushViewController:[HXHostProfileViewController instance] animated:YES];
            break;
        }
        case HXDiscoveryTopBarActionMusic: {
            UINavigationController *playNavigationController = [HXPlayViewController navigationControllerInstance];
            [self presentViewController:playNavigationController animated:YES completion:nil];
            break;
        }
    }
}

#pragma mark - HXDiscoveryContainerDelegate Methods
- (void)container:(HXDiscoveryContainerViewController *)container takeAction:(HXDiscoveryContainerAction)action model:(HXDiscoveryModel *)model {
    [container stopPreviewVideo];
    [self hiddenNavigationBar];
    switch (action) {
        case HXDiscoveryContainerActionRefresh: {
            [self showLoadingHUD];
            [self startFetchList];
            break;
        }
        case HXDiscoveryContainerActionScroll: {
            [self showCoverWithCoverUrl:model.coverUrl];
            break;
        }
        case HXDiscoveryContainerActionStartLive: {
            [self pauseMusic];
            HXRecordLiveViewController *recordLiveController = [HXRecordLiveViewController instance];
            [self presentViewController:recordLiveController animated:YES completion:nil];
            break;
        }
        case HXDiscoveryContainerActionChangeCover: {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            [self presentViewController:imagePickerController animated:YES completion:nil];
            break;
        }
        case HXDiscoveryContainerActionShowLive: {
            [self pauseMusic];
			UINavigationController *watchLiveNavigationController = nil;
			if (model.horizontal) {
				watchLiveNavigationController = [HXWatchLiveLandscapeViewController navigationControllerInstance];
			} else {
				watchLiveNavigationController = [HXWatchLiveViewController navigationControllerInstance];
			}

            HXWatchLiveViewController *watchLiveViewController = [watchLiveNavigationController.viewControllers firstObject];;
            watchLiveViewController.roomID = model.roomID;
            [self presentViewController:watchLiveNavigationController animated:YES completion:nil];
            break;
        }
        case HXDiscoveryContainerActionShowStation: {
            MIAProfileViewController *profileViewController = [MIAProfileViewController new];
            [profileViewController setUid:model.uID];
            [self.navigationController pushViewController:profileViewController animated:YES];
            break;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self uploadCoverImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
