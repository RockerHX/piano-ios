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
#import "HXReplayViewController.h"

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
//    [[self.showImageView layer] setBorderWidth:0.5];
//    [[self.showImageView layer] setBorderColor:[UIColor grayColor].CGColor];
    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Replay_Name]];
    
    [self.showTipLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Replay_Date]];
    
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithHeightWidthRatioValue:1. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showImageView distance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[self.showTitleLabel sizeThatFits:JOMAXSize].height + 6 selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithTopView:self.showTitleLabel distance:0 selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftXView:self.showImageView selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:self.showImageView selfView:self.showTipLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTipLabel superView:self];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:5. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_numberlabel sizeThatFits:JOMAXSize].height+4. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_numberlabel sizeThatFits:JOMAXSize].width + 8. selfView:_numberlabel superView:self];
    
    [JOAutoLayout autoLayoutWithRightView:_numberlabel distance:-5. selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_numberlabel selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_numberlabel selfView:_videoImageView superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_videoImageView superView:self];
    
}

- (void)createTipNumberView{
    
    if (!self.videoImageView) {
        
        self.videoImageView = [UIImageView newAutoLayoutView];
        [_videoImageView setBackgroundColor:JORGBCreate(230., 230., 230., 0.7)];
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
        [_numberlabel setText:_replayModel.viewCnt];
        
        [self updateViewLayout];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileReplayView exception" reason:@"data 不是MIAReplayModel类型"];
    }
}

#pragma mark - tag action

- (void)tapAction:(UIGestureRecognizer *)gesture {
    UINavigationController *replayNaviagtionController = [HXReplayViewController navigationControllerInstance];
    HXReplayViewController *replayViewController = [replayNaviagtionController.viewControllers firstObject];
    replayViewController.model = [HXDiscoveryModel createWithReplayModel:_replayModel];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:replayNaviagtionController animated:YES completion:nil];
}

@end
