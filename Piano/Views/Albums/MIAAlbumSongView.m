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
//@property (nonatomic, strong) UIImageView *playStateImageView;
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
    
    [_indexLabel layoutLeft:0. layoutItemHandler:nil];
    [_indexLabel layoutTop:0. layoutItemHandler:nil];
    [_indexLabel layoutBottom:0. layoutItemHandler:nil];
    [_indexLabel layoutWidth:kIndexLabelWidth layoutItemHandler:nil];
    
    self.downloadStateImageView = [UIImageView newAutoLayoutView];
    [_downloadStateImageView setImage:[UIImage imageNamed:@"AD-NoDownload"]];
    [_downloadStateImageView setHidden:YES];
    [self addSubview:_downloadStateImageView];
    
    [_downloadStateImageView layoutLeftView:_indexLabel distance:-2 layoutItemHandler:nil];
    [_downloadStateImageView layoutCenterYView:self layoutItemHandler:nil];
    [_downloadStateImageView layoutSize:JOSize(CGFLOAT_MIN, kDownloadTipImageWidth) layoutItemHandler:nil];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Time]];
    [_timeLabel setHidden:YES];
    [self addSubview:_timeLabel];
    
    [_timeLabel layoutRight:-10. layoutItemHandler:nil];
    [_timeLabel layoutTopYView:_indexLabel distance:0. layoutItemHandler:nil];
    [_timeLabel layoutBottomYView:_indexLabel distance:0. layoutItemHandler:nil];
    [_timeLabel layoutWidth:CGFLOAT_MIN layoutItemHandler:nil];
    
    self.songNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]];
    [_songNameLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:_songNameLabel];
    
    [_songNameLabel layoutLeftView:_downloadStateImageView distance:0. layoutItemHandler:nil];
    [_songNameLabel layoutTopYView:_indexLabel distance:0. layoutItemHandler:nil];
    [_songNameLabel layoutBottomYView:_indexLabel distance:0. layoutItemHandler:nil];
    [_songNameLabel layoutRightView:_timeLabel distance:-5. layoutItemHandler:nil];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]->color];
    [self addSubview:separateLineView];
    
    [separateLineView layoutLeftView:_indexLabel distance:0. layoutItemHandler:nil];
    [separateLineView layoutBottom:0. layoutItemHandler:nil];
    [separateLineView layoutRight:0. layoutItemHandler:nil];
    [separateLineView layoutHeight:0.5 layoutItemHandler:nil];
}

- (void)changeSongPlayState:(BOOL)state{
    
    [_timeLabel setHidden:!state];
    
    UIColor *textColor = [UIColor whiteColor];
    if (state) {
        textColor = [UIColor blackColor];
    }else{
        textColor = [MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]->color;
    }
    [_indexLabel setTextColor:textColor];
    [_songNameLabel setTextColor:textColor];
}

- (void)openAlbumSongDownloadState{

    [_downloadStateImageView setHidden:NO];
    [_downloadStateImageView layoutSize:JOSize(kDownloadTipImageWidth, kDownloadTipImageWidth) layoutItemHandler:nil];
    [_songNameLabel layoutLeftView:_downloadStateImageView distance:5. layoutItemHandler:nil];
}

- (void)setSongData:(id)data{

    if ([data isKindOfClass:[HXSongModel class]]) {
        
        self.songModel = nil;
        self.songModel = data;
        
        [_timeLabel setText:_songModel.durationPrompt];
        [_songNameLabel setText:_songModel.title];
        
        [_timeLabel layoutWidth:[_timeLabel sizeThatFits:JOMAXSize].width layoutItemHandler:nil];
        
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
