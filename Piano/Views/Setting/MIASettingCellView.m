//
//  MIASettingCellView.m
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASettingCellView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kSettingViewLeftSpaceDistance = 18.;//左边的间距
static CGFloat const kSettingViewRightSpaceDistance = 14.;//右边的间距.

@interface MIASettingCellView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *accessoryImageView;

@end

@implementation MIASettingCellView

- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setBackgroundColor:[UIColor clearColor]]
        [self createCellView];
    }
    return self;
}

- (void)createCellView{

    self.titleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Setting_CellTitle]];
    [self addSubview:_titleLabel];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kSettingViewLeftSpaceDistance selfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_titleLabel superView:self];
    
    self.accessoryImageView = [UIImageView newAutoLayoutView];
    [self addSubview:_accessoryImageView];
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kSettingViewRightSpaceDistance selfView:_accessoryImageView superView:self];
    [JOAutoLayout autoLayoutWithCenterYWithView:self selfView:_accessoryImageView superView:self];
    [JOAutoLayout autoLayoutWithSize:CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN) selfView:_accessoryImageView superView:self];
    
    self.contentLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Setting_CellContent]];
    [_contentLabel setTextAlignment:NSTextAlignmentRight];
    [_contentLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:_contentLabel];
    
    [JOAutoLayout autoLayoutWithRightView:_accessoryImageView distance:-5. selfView:_contentLabel superView:self];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_contentLabel superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_contentLabel superView:self];
    [JOAutoLayout autoLayoutWithLeftView:_titleLabel distance:10. selfView:_contentLabel superView:self];
}

- (void)setTitle:(NSString *)title content:(NSString *)content{

    [_titleLabel setText:title];
    [_contentLabel setText:content];

    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_titleLabel sizeThatFits:JOMAXSize].width+1 selfView:_titleLabel superView:self];
}

- (void)setTitleAttributedText:(NSAttributedString *)attributedTitle{

    [_titleLabel setAttributedText:attributedTitle];
    
    [JOAutoLayout removeAutoLayoutWithWidthSelfView:_titleLabel superView:self];
    [JOAutoLayout autoLayoutWithWidth:[_titleLabel sizeThatFits:JOMAXSize].width+1 selfView:_titleLabel superView:self];
}

- (void)setAccessoryImage:(UIImage *)image{

    if (image) {
        //图片存在的情况下
        [_accessoryImageView setImage:image];
        
        [JOAutoLayout removeAutoLayoutWithSizeSelfView:_accessoryImageView superView:self];
        [JOAutoLayout removeAutoLayoutWithRightSelfView:_contentLabel superView:self];
        
        CGSize imageSize = image.size;
        [JOAutoLayout autoLayoutWithSize:imageSize selfView:_accessoryImageView superView:self];
        
        [JOAutoLayout autoLayoutWithRightView:_accessoryImageView distance:-5. selfView:_contentLabel superView:self];
    }else{
    
        [JOAutoLayout removeAutoLayoutWithSizeSelfView:_accessoryImageView superView:self];
        [JOAutoLayout removeAutoLayoutWithRightSelfView:_contentLabel superView:self];
        
        CGSize imageSize = JOSize(CGFLOAT_MIN, CGFLOAT_MIN);
        [JOAutoLayout autoLayoutWithSize:imageSize selfView:_accessoryImageView superView:self];
        
        [JOAutoLayout autoLayoutWithRightView:_accessoryImageView distance:-0. selfView:_contentLabel superView:self];
    }
}

@end
