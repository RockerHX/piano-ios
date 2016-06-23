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
        [self createCellView];
    }
    return self;
}

- (void)createCellView{

    self.titleLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Setting_CellTitle]];
    [self addSubview:_titleLabel];
    
    [_titleLabel layoutLeft:kSettingViewLeftSpaceDistance layoutItemHandler:nil];
    [_titleLabel layoutTop:0. layoutItemHandler:nil];
    [_titleLabel layoutBottom:0. layoutItemHandler:nil];
    [_titleLabel layoutWidth:CGFLOAT_MIN layoutItemHandler:nil];
    
    self.accessoryImageView = [UIImageView newAutoLayoutView];
    [self addSubview:_accessoryImageView];
    
    [_accessoryImageView layoutRight:-kSettingViewRightSpaceDistance layoutItemHandler:nil];
    [_accessoryImageView layoutCenterYView:self layoutItemHandler:nil];
    [_accessoryImageView layoutSize:CGSizeMake(CGFLOAT_MIN, CGFLOAT_MIN) layoutItemHandler:nil];
    
    self.contentLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Setting_CellContent]];
    [_contentLabel setTextAlignment:NSTextAlignmentRight];
    [_contentLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [self addSubview:_contentLabel];
    
    [_contentLabel layoutRightView:_accessoryImageView distance:-5. layoutItemHandler:nil];
    [_contentLabel layoutTop:0. layoutItemHandler:nil];
    [_contentLabel layoutBottom:0. layoutItemHandler:nil];
    [_contentLabel layoutLeftView:_titleLabel distance:10. layoutItemHandler:nil];
}

- (void)setTitle:(NSString *)title content:(NSString *)content{

    [_titleLabel setText:title];
    [_contentLabel setText:content];
    [_titleLabel layoutWidth:[_titleLabel sizeThatFits:JOMAXSize].width+1 layoutItemHandler:nil];
}

- (void)setTitleAttributedText:(NSAttributedString *)attributedTitle{

    [_titleLabel setAttributedText:attributedTitle];
    [_titleLabel layoutWidth:[_titleLabel sizeThatFits:JOMAXSize].width+1 layoutItemHandler:nil];
}

- (void)setAccessoryImage:(UIImage *)image{

    if (image) {
        //图片存在的情况下
        [_accessoryImageView setImage:image];

        CGSize imageSize = image.size;
        [_accessoryImageView layoutSize:imageSize layoutItemHandler:nil];
        [_contentLabel layoutRightView:_accessoryImageView distance:-5. layoutItemHandler:nil];
        
    }else{
        
        CGSize imageSize = JOSize(CGFLOAT_MIN, CGFLOAT_MIN);
        [_accessoryImageView layoutSize:imageSize layoutItemHandler:nil];
        [_contentLabel layoutRightView:_accessoryImageView distance:-0. layoutItemHandler:nil];
    }
}

@end
