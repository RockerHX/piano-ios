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

static CGFloat const kTitleLabelHeight = 20.;

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
    [[self.showImageView layer] setCornerRadius:3.];
    [self.showTitleLabel setJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Video_Name]];
   
    [self.showTipLabel setHidden:YES];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0 selfView:self.showTitleLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:kTitleLabelHeight selfView:self.showTitleLabel superView:self];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:self.showImageView superView:self];
    [JOAutoLayout autoLayoutWithBottomView:self.showTitleLabel distance:0. selfView:self.showImageView superView:self];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:5. selfView:_numberlabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_numberlabel sizeThatFits:JOMAXSize].height selfView:_numberlabel superView:self];
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
        
        self.numberlabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Profile_Video_ViweCount]];
        [self addSubview:_numberlabel];
    }
}

- (void)setShowData:(id)data{
    
    
    if ([data isKindOfClass:[MIAVideoModel class]]) {
        
        self.videoModel = nil;
        self.videoModel = data;
        
        [self createTipNumberView];
        
        NSString *viewCount = JOConvertStringToNormalString(_videoModel.viewCnt);
        
        [self.showImageView sd_setImageWithURL:[NSURL URLWithString:_videoModel.coverUrl] placeholderImage:nil];
        [self.showTitleLabel setText:_videoModel.title];
        [_numberlabel setText:[viewCount length]?viewCount:@"0"];
        
        [self updateViewLayout];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAProfileVideoView exception!" reason:@"data需要为MIAVideoModel类型"];
    }
    
}

#pragma mark - tag action

- (void)tapAction:(UIGestureRecognizer *)gesture{
    
    MIAVideoPlayViewController *videoViewController = [MIAVideoPlayViewController new];
    [videoViewController setVideoURLString:_videoModel.videoUrl];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [(UINavigationController *)[[delegate window] rootViewController] presentViewController:videoViewController animated:YES completion:^{
        
    }];
}

@end
