//
//  MIAProfileReplayView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileReplayView.h"
#import "AppDelegate.h"
#import "MIAReplayModel.h"
#import "HXReplayLandscapeViewController.h"
#import "MusicMgr.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "UserSetting.h"
#import "BlocksKit+UIKit.h"

CGFloat kProfileReplayImageToTitleSpaceDistance = 9. ;
CGFloat kProfileReplayTitleToTipSpaceDistance =  2.;

//直播回放的  宽/高  16:9

@interface MIAProfileReplayView()

@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *numberlabel;

@end

@implementation MIAProfileReplayView {
    MIAReplayModel *_replayModel;
}

- (void)addTapGesture{
    
    if (objc_getAssociatedObject(self, _cmd)) {
        //
    }else{
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
        objc_setAssociatedObject(self, _cmd, @"only", OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)updateViewLayout{
    
    [super updateViewLayout];
    
    [self addTapGesture];
    [self.showImageView setBackgroundColor:JORGBCreate(230., 230., 230., 1.)];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Replay_Name]];
    
    [self.showTipLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Replay_Date]];
    
    [self.showImageView layoutLeft:0. layoutItemHandler:nil];
    [self.showImageView layoutRight:0. layoutItemHandler:nil];
    [self.showImageView layoutTop:0. layoutItemHandler:nil];
    [self.showImageView layoutHeightWidthRatio:9./16. layoutItemHandler:nil];
    
    [self.showTitleLabel layoutTopView:self.showImageView distance:kProfileReplayImageToTitleSpaceDistance layoutItemHandler:nil];
    [self.showTitleLabel layoutLeftXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutRightXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTitleLabel layoutHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
    
    [self.showTipLabel layoutTopView:self.showTitleLabel distance:kProfileReplayTitleToTipSpaceDistance layoutItemHandler:nil];
    [self.showTipLabel layoutLeftXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTipLabel layoutRightXView:self.showImageView distance:0. layoutItemHandler:nil];
    [self.showTipLabel layoutBottom:0. layoutItemHandler:nil];
    
    [_numberlabel layoutRight:0. layoutItemHandler:nil];
    [_numberlabel layoutTop:7. layoutItemHandler:nil];
    [_numberlabel layoutHeight:[_numberlabel sizeThatFits:JOMAXSize].height+4. layoutItemHandler:nil];
    [_numberlabel layoutWidth:[_numberlabel sizeThatFits:JOMAXSize].width + 8. layoutItemHandler:nil];
    
    UIImage *videoImage = [UIImage imageNamed:@"PR-Video"];
    
    [_videoImageView layoutRightView:_numberlabel distance:-5. layoutItemHandler:nil];
    [_videoImageView layoutTopYView:_numberlabel distance:0. layoutItemHandler:nil];
    [_videoImageView layoutBottomYView:_numberlabel distance:0. layoutItemHandler:nil];
    [_videoImageView layoutWidth:videoImage.size.width layoutItemHandler:nil];
    
}

- (void)createTipNumberView{
    
    if (!self.videoImageView) {
        
        self.videoImageView = [UIImageView newAutoLayoutView];
        [_videoImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_videoImageView setImage:[UIImage imageNamed:@"PR-Video"]];
        [self addSubview:_videoImageView];
        
        self.numberlabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Replay_ViweCount]];
        [self addSubview:_numberlabel];
    }
}

- (void)setShowData:(id)data {
    
    if ([data isKindOfClass:[MIAReplayModel class]]) {
    
        [self createTipNumberView];
        
        _replayModel = data;
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:_replayModel.coverUrl] placeholderImage:nil];
        [self.showTitleLabel setText:_replayModel.title];
        [self.showTipLabel setText:[_replayModel.createTime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterMonthDay]];
        [_numberlabel setText:_replayModel.replayCnt];
        
        [self updateViewLayout];
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileReplayView exception" reason:@"data 不是MIAReplayModel类型"];
    }
}

#pragma mark - tag action

- (void)enterReplayViewController{

    //视频统计.
    [MiaAPIHelper videoCountWithID:_replayModel.roomID
                     completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
                         
                         if (success) {
                             //            JOLog(@"视频统计成功");
                             NSString *viewCount = [NSString stringWithFormat:@"%ld",(long)[JOConvertStringToNormalString(_replayModel.replayCnt) integerValue] +1];
                             _replayModel.replayCnt = viewCount;
                             [_numberlabel setText:viewCount];
                         }else{
                             //            JOLog(@"error:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Error]);
                         }
                     } timeoutBlock:^(MiaRequestItem *requestItem) {
                         
                     }];
    
    HXReplayViewController *replayViewController = nil;
    if (_replayModel.horizontal) {
        replayViewController = [HXReplayLandscapeViewController instance];
    } else {
        replayViewController = [HXReplayViewController instance];
    }
    replayViewController.model = [HXDiscoveryModel createWithReplayModel:_replayModel];
    replayViewController.model.uID = _uid;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:replayViewController animated:YES completion:^{
        if ([[MusicMgr standard] isPlaying]) {
            [[MusicMgr standard] pause];
        }
    }];
}

- (void)tapAction:(UIGestureRecognizer *)gesture {

	if ([[WebSocketMgr standard] isWifiNetwork] || [UserSetting playWith3G]) {
		[self enterReplayViewController];
	} else {
		[UIAlertView bk_showAlertViewWithTitle:k3GPlayTitle message:k3GPlayMessage cancelButtonTitle:k3GPlayCancel otherButtonTitles:@[k3GPlayAllow] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
			if (buttonIndex != alertView.cancelButtonIndex) {
				[self enterReplayViewController];
			}
		}];
	}
}

@end
