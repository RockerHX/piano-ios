//
//  MIAAlbumSongView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumSongView.h"
#import "MIASongManage.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"
#import "HXSongModel.h"

static CGFloat const kIndexLabelWidth = 40.; //label的宽度

static CGFloat const kDownloadTipImageWidth = 20.;//下载按钮的提示图片的宽度

@interface MIAAlbumSongView()

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *playStateImageView;
@property (nonatomic, strong) UIImageView *downloadStateImageView;
@property (nonatomic, strong) HXSongModel *songModel;

@end

@implementation MIAAlbumSongView

- (instancetype)init{

    self = [super init];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self createSongView];
    }
    return self;
}

- (void)createSongView{

    self.indexLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]];
    [_indexLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_indexLabel];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_indexLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_indexLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_indexLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:kIndexLabelWidth selfView:_indexLabel superView:self];
    
    self.playStateImageView = [UIImageView newAutoLayoutView];
    [_playStateImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_playStateImageView setImage:[UIImage imageNamed:@"AD-PauseIcon-S"]];
    [_playStateImageView setHidden:YES];
    [self addSubview:_playStateImageView];
    
    [JOAutoLayout autoLayoutWithSize:JOSize(kIndexLabelWidth-15., kIndexLabelWidth-15.) selfView:_playStateImageView superView:self];
    [JOAutoLayout autoLayoutWithCenterWithView:_indexLabel selfView:_playStateImageView superView:self];
    
    self.downloadStateImageView = [UIImageView newAutoLayoutView];
    [_downloadStateImageView setImage:[UIImage imageNamed:@"AD-NoDownload"]];
    [_downloadStateImageView setHidden:YES];
    [self addSubview:_downloadStateImageView];
    
    //初始化宽度为0
    [JOAutoLayout autoLayoutWithLeftView:_indexLabel distance:0. selfView:_downloadStateImageView superView:self];
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_downloadStateImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(CGFLOAT_MIN, kDownloadTipImageWidth) selfView:_downloadStateImageView superView:self];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Time]];
    [_timeLabel setHidden:YES];
    [self addSubview:_timeLabel];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_indexLabel selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_indexLabel selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_timeLabel superView:self];
    
    self.songNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]];
    [self addSubview:_songNameLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:_downloadStateImageView distance:5. selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_indexLabel selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_indexLabel selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithRightView:_timeLabel distance:5. selfView:_songNameLabel superView:self];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]->color];
    [self addSubview:separateLineView];
    
    [JOAutoLayout autoLayoutWithLeftXView:_downloadStateImageView selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithHeight:0.5 selfView:separateLineView superView:self];
}

- (void)changeSongPlayState:(BOOL)state{
    
    [_timeLabel setHidden:!state];
    [_indexLabel setHidden:state];
    [_playStateImageView setHidden:!state];
    
    UIColor *textColor = [UIColor whiteColor];
    if (state) {
        textColor = [UIColor blackColor];
    }else{
        textColor = [MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]->color;
    }
    [_songNameLabel setTextColor:textColor];
}

- (void)openAlbumSongDownloadState{

    [_downloadStateImageView setHidden:NO];
    [JOAutoLayout removeAutoLayoutWithSizeSelfView:_downloadStateImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(kDownloadTipImageWidth, kDownloadTipImageWidth) selfView:_downloadStateImageView superView:self];
}

- (void)setSongData:(id)data{

    if ([data isKindOfClass:[HXSongModel class]]) {
        
        self.songModel = nil;
        self.songModel = data;
        
        [_timeLabel setText:_songModel.durationPrompt];
        [_songNameLabel setText:_songModel.title];
        
        [JOAutoLayout removeAutoLayoutWithWidthSelfView:_timeLabel superView:self];
        [JOAutoLayout autoLayoutWithWidth:[_timeLabel sizeThatFits:JOMAXSize].width selfView:_timeLabel superView:self];
        
        //更改歌曲存在状态标记的图片
        if ([[MIASongManage shareSongManage] songIsExistWithURLString:_songModel.mp3Url]) {
            
            [_downloadStateImageView setImage:[UIImage imageNamed:@"AD-Download"]];
        }else{
        
            [_downloadStateImageView setImage:[UIImage imageNamed:@"AD-NoDownload"]];
        }
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumSongView exception!" reason:@"data必须是MIASongModel类型"];
    }
}

- (void)setSongIndex:(NSInteger)index{

    [_indexLabel setText:[NSString stringWithFormat:@"%ld",(long)index]];
}

@end
