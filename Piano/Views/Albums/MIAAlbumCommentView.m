//
//  MIAAlbumCommentView.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumCommentView.h"
#import "NSString+JOExtend.h"
#import "UIImageView+WebCache.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"
#import "MIACommentModel.h"

CGFloat const kImageToLabelSpaceDistance = 10.;//图片与label之间的间距
CGFloat const kImageWidth = 42.;//图片的宽度
CGFloat const kCommentContentRightSpaceDistance = 10.;//评论内容右间距大小.

@interface MIAAlbumCommentView(){

    CGFloat viewWidth;
}

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *separateLineView;

@property (nonatomic, strong) MIACommentModel *commentModel;

@end

@implementation MIAAlbumCommentView

- (instancetype)init{

    self = [super init];
    if (self) {
        viewWidth = 200.;
        [self createCommentView];
    }
    return self;
}

- (void)createCommentView{

    self.headImageView = [UIImageView newAutoLayoutView];
    [[_headImageView layer] setCornerRadius:kImageWidth/2.];
    [[_headImageView layer] setMasksToBounds:YES];
    [[_headImageView layer] setBorderWidth:0.5];
    [[_headImageView layer] setBorderColor:JORGBSameCreate(220.).CGColor];
    [_headImageView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:_headImageView];
    
    [_headImageView layoutTop:0. layoutItemHandler:nil];
    [_headImageView layoutLeft:0. layoutItemHandler:nil];
    [_headImageView layoutSize:JOSize(kImageWidth, kImageWidth) layoutItemHandler:nil];
    
    self.nickNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Name]];
    [_nickNameLabel setText:@" "];
    [self addSubview:_nickNameLabel];
    
    [_nickNameLabel layoutLeftView:_headImageView distance:kImageToLabelSpaceDistance layoutItemHandler:nil];
    [_nickNameLabel layoutTopYView:_headImageView distance:3. layoutItemHandler:nil];
    [_nickNameLabel layoutRight:-kCommentContentRightSpaceDistance layoutItemHandler:nil];
    [_nickNameLabel layoutHeight:[_nickNameLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
    
    self.commentLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Content]];
    [_commentLabel setText:@" "];
    [_commentLabel setNumberOfLines:0];
    [self addSubview:_commentLabel];
    
    [_commentLabel layoutLeftXView:_nickNameLabel distance:0. layoutItemHandler:nil];
    [_commentLabel layoutTopView:_nickNameLabel distance:0. layoutItemHandler:nil];
    [_commentLabel layoutRightXView:_nickNameLabel distance:0. layoutItemHandler:nil];
    [_commentLabel layoutHeight:[_commentLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Time]];
    [_timeLabel setText:@" "];
    [self addSubview:_timeLabel];
    
    [_timeLabel layoutLeftXView:_nickNameLabel distance:0. layoutItemHandler:nil];
    [_timeLabel layoutRightXView:_nickNameLabel distance:0. layoutItemHandler:nil];
    [_timeLabel layoutTopView:_commentLabel distance:0. layoutItemHandler:nil];
    [_timeLabel layoutHeight:[_timeLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
    
    self.separateLineView = [UIView newAutoLayoutView];
    [_separateLineView setBackgroundColor:JORGBSameCreate(220.)];
    [self addSubview:_separateLineView];
    
    [_separateLineView layoutLeftXView:_nickNameLabel distance:0. layoutItemHandler:nil];
    [_separateLineView layoutRight:0. layoutItemHandler:nil];
    [_separateLineView layoutBottom:9.5 layoutItemHandler:nil];
    [_separateLineView layoutHeight:0.5 layoutItemHandler:nil];
}

- (void)setAlbumCommentData:(id)data{

    if ([data isKindOfClass:[MIACommentModel class]]) {
        
        self.commentModel = nil;
        self.commentModel = data;
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_commentModel.userpic] placeholderImage:[UIImage imageNamed:@"C-DefaultAvatar"]];
        [_nickNameLabel setText:_commentModel.nick];
        [_commentLabel setText:_commentModel.content];
        [_timeLabel setText:[_commentModel.addtime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterMonthDay]];
        
        [_commentLabel layoutHeight:[_commentLabel sizeThatFits:JOSize(viewWidth, CGFLOAT_MAX)].height layoutItemHandler:nil];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumCommentView exception!" reason:@"data必须是MIACommentModel类型"];
    }
}

- (void)setCommentViewWidth:(CGFloat)width{

    viewWidth = width - kImageWidth - kImageToLabelSpaceDistance;
}

@end
