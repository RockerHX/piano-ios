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

static CGFloat const kImageToLabelSpaceDistance = 15.;//图片与label之间的间距
static CGFloat const kImageWidth = 36.;//图片的宽度

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
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_headImageView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_headImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:JOSize(kImageWidth, kImageWidth) selfView:_headImageView superView:self];
    
    self.nickNameLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Name]];
    [_nickNameLabel setText:@" "];
    [self addSubview:_nickNameLabel];
    
    [JOAutoLayout autoLayoutWithLeftView:_headImageView distance:kImageToLabelSpaceDistance selfView:_nickNameLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_nickNameLabel superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_nickNameLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_nickNameLabel sizeThatFits:JOMAXSize].height+4. selfView:_nickNameLabel superView:self];
    
    self.commentLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Content]];
    [_commentLabel setText:@" "];
    [_commentLabel setNumberOfLines:0];
    [self addSubview:_commentLabel];
    
    [JOAutoLayout autoLayoutWithLeftXView:_nickNameLabel selfView:_commentLabel superView:self];
    [JOAutoLayout autoLayoutWithTopView:_nickNameLabel distance:0. selfView:_commentLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:_nickNameLabel selfView:_commentLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_commentLabel sizeThatFits:JOMAXSize].height+4 selfView:_commentLabel superView:self];
    
    self.timeLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Album_Comment_Time]];
    [_timeLabel setText:@" "];
    [self addSubview:_timeLabel];
    
    [JOAutoLayout autoLayoutWithLeftXView:_nickNameLabel selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithRightXView:_nickNameLabel selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithTopView:_commentLabel distance:0. selfView:_timeLabel superView:self];
    [JOAutoLayout autoLayoutWithHeight:[_timeLabel sizeThatFits:JOMAXSize].height selfView:_timeLabel superView:self];
    
    self.separateLineView = [UIView newAutoLayoutView];
    [_separateLineView setBackgroundColor:JORGBSameCreate(220.)];
    [self addSubview:_separateLineView];
    
    [JOAutoLayout autoLayoutWithLeftXView:_nickNameLabel selfView:_separateLineView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_separateLineView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:9.5 selfView:_separateLineView superView:self];
    [JOAutoLayout autoLayoutWithHeight:0.5 selfView:_separateLineView superView:self];
}

- (void)setAlbumCommentData:(id)data{

    if ([data isKindOfClass:[MIACommentModel class]]) {
        
        self.commentModel = nil;
        self.commentModel = data;
        
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:_commentModel.userpic] placeholderImage:[UIImage imageNamed:@"C-DefaultAvatar"]];
        [_nickNameLabel setText:_commentModel.nick];
        [_commentLabel setText:_commentModel.content];
        [_timeLabel setText:[_commentModel.addtime JOConvertTimelineToDateStringWithFormatterType:JODateFormatterMonthDay]];
        
        [JOAutoLayout removeAutoLayoutWithHeightSelfView:_commentLabel superView:self];
        [JOAutoLayout autoLayoutWithHeight:[_commentLabel sizeThatFits:JOSize(viewWidth, CGFLOAT_MAX)].height+4 selfView:_commentLabel superView:self];
        
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumCommentView exception!" reason:@"data必须是MIACommentModel类型"];
    }
}

- (void)setCommentViewWidth:(CGFloat)width{

    viewWidth = width - kImageWidth - kImageToLabelSpaceDistance;
}

@end
