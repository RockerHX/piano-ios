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
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kLeftSpaceDistance selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kRightSpaceDistance selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kTopSpaceDistance selfView:_songNameLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_songNameLabel sizeThatFits:JOMAXSize].height+1 selfView:_songNameLabel superView:self];
    
    self.nameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Bar_Name]];
    [_nameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nameLabel setText:@" "];
    [self addSubview:_nameLabel];
    
    [JOAutoLayout autoLayoutWithLeftXView:_songNameLabel selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:_songNameLabel selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithTopView:_songNameLabel distance:0. selfView:_nameLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_nameLabel sizeThatFits:JOMAXSize].height+1 selfView:_nameLabel superView:self];
    
    self.popButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_popButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_popButton setImage:[UIImage imageNamed:@"C-BackIcon-White"] forState:UIControlStateNormal];
    [_popButton addTarget:self action:@selector(popButtonClikc) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_popButton];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_popButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_popButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_popButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_popButton superView:self];
    
    self.reportButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reportButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_reportButton setImage:[UIImage imageNamed:@"C-More"] forState:UIControlStateNormal];
    [_reportButton addTarget:self action:@selector(reportButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reportButton];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_reportButton superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_reportButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_reportButton superView:self];
    [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_reportButton superView:self];
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
