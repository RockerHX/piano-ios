//
//  MIAAlbumBarView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumBarView.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"

static CGFloat const kTopSpaceDistance = 5.;//上部的间距大小
static CGFloat const kLeftSpaceDistance = 10.;//左边的间距大小
static CGFloat const kRightSpaceDistance = 10.;//右边的间距大小
//static CGFloat const kBottomSpaceDistance = 5.;//底部的间距大小

@interface MIAAlbumBarView()

@property (nonatomic, strong) UILabel *songNameLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *popButton;
@property (nonatomic, strong) UIButton *reportButton;

@property (nonatomic, copy) PopActionBlock popActionBlock;
@property (nonatomic, copy) ReportActionBlock reportActionBlock;

@end

@implementation MIAAlbumBarView

- (instancetype)init{

    self = [super init];
    if (self) {
        
        [self createBarView];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)createBarView{

    self.songNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Bar_Title]];
    [_songNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_songNameLabel setText:@" "];
    [self addSubview:_songNameLabel];
    
    [_songNameLabel layoutLeft:kLeftSpaceDistance layoutItemHandler:nil];
    [_songNameLabel layoutRight:-kRightSpaceDistance layoutItemHandler:nil];
    [_songNameLabel layoutTop:kTopSpaceDistance layoutItemHandler:nil];
    [_songNameLabel layoutHeight:[_songNameLabel sizeThatFits:JOMAXSize].height+1 layoutItemHandler:nil];
    
    self.nameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Bar_Name]];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setText:@" "];
    [self addSubview:_nameLabel];
    
    [_nameLabel layoutLeftXView:_songNameLabel distance:0. layoutItemHandler:nil];
    [_nameLabel layoutRightXView:_songNameLabel distance:0. layoutItemHandler:nil];
    [_nameLabel layoutTopView:_songNameLabel distance:0. layoutItemHandler:nil];
    [_nameLabel layoutHeight:[_nameLabel sizeThatFits:JOMAXSize].height+1 layoutItemHandler:nil];
    
    UIImage *popImage = [UIImage imageNamed:@"C-BackIcon-White"];
    UIImageView *popImageView = [UIImageView newAutoLayoutView];
    [popImageView setImage:popImage];
    [self addSubview:popImageView];
    
    [popImageView layoutTopYView:_songNameLabel distance:0. layoutItemHandler:nil];
    [popImageView layoutLeft:5. layoutItemHandler:nil];
    [popImageView layoutSize:popImage.size layoutItemHandler:nil];
    
    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_popButton addTarget:self action:@selector(popButtonClikc) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_popButton];
    
    [_popButton layoutLeft:0. layoutItemHandler:nil];
    [_popButton layoutTop:0. layoutItemHandler:nil];
    [_popButton layoutBottom:0. layoutItemHandler:nil];
    [_popButton layoutWidthHeightRatio:1. layoutItemHandler:nil];
    
    UIImage *reportImage = [UIImage imageNamed:@"C-More"];
    UIImageView *reportImageView = [UIImageView newAutoLayoutView];
    [reportImageView setImage:reportImage];
    [self addSubview:reportImageView];
    
    [reportImageView layoutTopYView:_songNameLabel distance:-3. layoutItemHandler:nil];
    [reportImageView layoutRight:-10. layoutItemHandler:nil];
    [reportImageView layoutSize:reportImage.size layoutItemHandler:nil];
    
    self.reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reportButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_reportButton addTarget:self action:@selector(reportButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reportButton];
    
    [_reportButton layoutRight:0. layoutItemHandler:nil];
    [_reportButton layoutTop:0. layoutItemHandler:nil];
    [_reportButton layoutBottom:0. layoutItemHandler:nil];
    [_reportButton layoutWidthHeightRatio:1. layoutItemHandler:nil];
}

- (void)popButtonClikc{

    if (_popActionBlock) {
        _popActionBlock();
    }
}

- (void)reportButtonClick{

    if (_reportActionBlock) {
        _reportActionBlock();
    }
}

- (void)popActionHandler:(PopActionBlock)block{

    self.popActionBlock = nil;
    self.popActionBlock = block;
}

- (void)reportActionHandler:(ReportActionBlock)block{

    self.reportActionBlock = nil;
    self.reportActionBlock = block;
}

- (void)setAlbumName:(NSString *)albumName singerName:(NSString *)singerName{

    [_songNameLabel setText:albumName];
    [_nameLabel setText:singerName];
}

@end
