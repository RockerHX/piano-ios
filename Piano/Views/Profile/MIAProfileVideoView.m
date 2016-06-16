//
//  MIAProfileVideoView.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAProfileVideoView.h"
#import "AppDelegate.h"
#import "MIAVideoPlayViewController.h"
#import "MIAVideoModel.h"
#import "MiaAPIHelper.h"
#import "WebSocketMgr.h"
#import "UserSetting.h"
#import "BlocksKit+UIKit.h"

CGFloat const kProfileVideoToTitleSpaceDistance = 7.;

@interface MIAProfileVideoView()

@property (nonatomic, strong) MIAVideoModel *videoModel;
@property (nonatomic, strong) UIImageView *videoImageView;
@property (nonatomic, strong) UILabel *numberlabel;

@end

@implementation MIAProfileVideoView

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
    
    [self.showImageView setBackgroundColor:JORGBSameCreate(230.)];
//    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Video_Name]];
   
    [self.showTipLabel setHidden:YES];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0 selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomView:self.showTitleLabel distance:-kProfileVideoToTitleSpaceDistance selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:7. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_numberlabel sizeThatFits:JOMAXSize].height selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_numberlabel sizeThatFits:JOMAXSize].width + 8. selfView:_numberlabel superView:self];
    
    UIImage *videoImage = [UIImage imageNamed:@"PR-Video"];
    
    [JOAutoLayout autoLayoutWithRightView:_numberlabel distance:-5. selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_numberlabel selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_numberlabel selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithWidth:videoImage.size.width selfView:_videoImageView superView:self];
    
}

- (void)createTipNumberView{

    if (!self.videoImageView) {
        
        self.videoImageView = [UIImageView newAutoLayoutView];
        [_videoImageView setContentMode:UIViewContentModeScaleAspectFit];
        [_videoImageView setImage:[UIImage imageNamed:@"PR-Video"]];
        [self addSubview:_videoImageView];
        
        self.numberlabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Video_ViweCount]];
        [self addSubview:_numberlabel];
    }
}

- (void)setShowData:(id)data{
    
    if ([data isKindOfClass:[MIAVideoModel class]]) {
        
        self.videoModel = nil;
        self.videoModel = data;
        
        [self createTipNumberView];
        
        NSString *viewCount = JOConvertStringToNormalString(_videoModel.playCnt);
        
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:_videoModel.coverUrl] placeholderImage:nil];
        [self.showTitleLabel setText:_videoModel.title];
        [_numberlabel setText:[viewCount length]?viewCount:@"0"];
        
        [self updateViewLayout];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileVideoView exception!" reason:@"data需要为MIAVideoModel类型"];
    }
    
}

#pragma mark - tag action

- (void)enterVideoViewController{

    //视频统计.
    [MiaAPIHelper videoCountWithID:_videoModel.id completeBlock:^(MiaRequestItem *requestItem, BOOL success, NSDictionary *userInfo) {
        
        if (success) {
            //            JOLog(@"视频统计成功");
            NSString *viewCount = [NSString stringWithFormat:@"%ld",(long)[JOConvertStringToNormalString(_videoModel.playCnt) integerValue] +1];
            _videoModel.playCnt = viewCount;
            [_numberlabel setText:viewCount];
        }else{
            //            JOLog(@"error:%@",userInfo[MiaAPIKey_Values][MiaAPIKey_Error]);
        }
        
    } timeoutBlock:^(MiaRequestItem *requestItem) {
        
    }];
    
    MIAVideoPlayViewController *videoViewController = [MIAVideoPlayViewController new];
    [videoViewController setVideoURLString:_videoModel.videoUrl];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(UINavigationController *)[[delegate window] rootViewController] presentViewController:videoViewController animated:YES completion:^{
        
    }];
}

- (void)tapAction:(UIGestureRecognizer *)gesture{
    
    if (![[WebSocketMgr standard] isWifiNetwork]) {
        if ([UserSetting playWith3G]) {
            [self enterVideoViewController];
        } else {
            [UIAlertView bk_showAlertViewWithTitle:@"温馨提示" message:@"当前非WIFI状态，是否使用流量继续观看？" cancelButtonTitle:@"取消" otherButtonTitles:@[@"我是土豪"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                if (buttonIndex != alertView.cancelButtonIndex) {
                    [self enterVideoViewController];
                }
            }];
        }
    }
}

@end
