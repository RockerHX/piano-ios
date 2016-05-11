//
//  MIAAlbumSongView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumSongView.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"

static CGFloat const kIndexLabelWidth = 40.;

@interface MIAAlbumSongView()

@property (nonatomic, strong) UILabel *indexLabel;
@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *playStateImageView;

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
    [_playStateImageView setImage:[UIImage imageNamed:@"AD-PauseIcon-L"]];
    [_playStateImageView setHidden:YES];
    [self addSubview:_playStateImageView];
    
    [JOAutoLayout autoLayoutWithSameView:_indexLabel selfView:_playStateImageView superView:self];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Time]];
    [_timeLabel setHidden:YES];
    [self addSubview:_timeLabel];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_indexLabel selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_indexLabel selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_timeLabel superView:self];
    
    self.songNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title]];
    [self addSubview:_songNameLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:_indexLabel distance:0. selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithTopYView:_indexLabel selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomYView:_indexLabel selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithRightView:_timeLabel distance:5. selfView:_songNameLabel superView:self];
    
    UIView *separateLineView = [UIView newAutoLayoutView];
    [separateLineView setBackgroundColor:[MIAFontManage getFontWithType:MIAFontType_Album_Song_Title].color];
    [self addSubview:separateLineView];
    
    [JOAutoLayout autoLayoutWithLeftXView:_songNameLabel selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-1. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:separateLineView superView:self];
    [JOAutoLayout autoLayoutWithHeight:1. selfView:separateLineView superView:self];
    
}

- (void)changeSongPlayState:(BOOL)state{

    [_timeLabel setText:@"4:34"];
    
    [_timeLabel setHidden:!state];
    [_indexLabel setHidden:state];
    [_playStateImageView setHidden:!state];
    
    UIColor *textColor = [UIColor whiteColor];
    if (state) {
        textColor = [UIColor blackColor];
    }else{
    
        textColor = [MIAFontManage getFontWithType:MIAFontType_Album_Song_Title].color;
    }
    
    [_songNameLabel setTextColor:textColor];
    
    [_songNameLabel setText:@"狂喜狂悲"];
    [_indexLabel setText:@"1"];
    
    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_timeLabel sizeThatFits:JOMAXSize].width selfView:_timeLabel superView:self];

}

@end
