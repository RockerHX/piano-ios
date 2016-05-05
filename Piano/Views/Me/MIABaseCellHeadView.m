//
//  MIABaseCellHeadView.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseCellHeadView.h"
#import "JOBaseSDK.h"

@interface MIABaseCellHeadView()

@end

@implementation MIABaseCellHeadView

- (void)createView{
    
    self.maskView = [UIView newAutoLayoutView];
    [_maskView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
    [self addSubview:_maskView];
    
    self.headImageView = [UIImageView newAutoLayoutView];
    [_headImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_maskView addSubview:_headImageView];
    
    self.headLabel = [UILabel newAutoLayoutView];
    [_headLabel setBackgroundColor:[UIColor clearColor]];
    [_headLabel setTextAlignment:NSTextAlignmentLeft];
    [_headLabel setTextColor:[UIColor whiteColor]];
    [_maskView addSubview:_headLabel];
    
    self.headTipLabel = [UILabel newAutoLayoutView];
    [_headTipLabel setBackgroundColor:[UIColor clearColor]];
    [_headTipLabel setTextAlignment:NSTextAlignmentLeft];
//    [_headTipLabel setTextColor:[UIColor grayColor]];
    [_maskView addSubview:_headTipLabel];
}

- (void)setHeadImage:(UIImage *)image
           headTitle:(NSString *)headTitle
        headTipTitle:(NSString *)headTipTitle
   baseCellColorType:(BaseCellHeadColorType)colorType{
    
    if (objc_getAssociatedObject(self, _cmd)) {
        //
    }else{
        [self createView];
        if (colorType == BaseCellHeadColorTypeWhiter) {
            [_headLabel setTextColor:[UIColor whiteColor]];
        }else{
        
            [_headLabel setTextColor:[UIColor blackColor]];
        }
        
        objc_setAssociatedObject(self, _cmd, @"only", OBJC_ASSOCIATION_RETAIN);
    }
    
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_maskView superView:self];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headImageView superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headLabel superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headTipLabel superView:_maskView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(10., 0., 0., 0.) selfView:_maskView superView:self];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:20. selfView:_headImageView superView:_maskView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:10. selfView:_headImageView superView:_maskView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-10. selfView:_headImageView superView:_maskView];
    if (image) {
        [_headImageView setImage:image];
        [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_headImageView superView:_maskView];
        [_headImageView setHidden:NO];
    }else{
        [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_headImageView superView:_maskView];
        [_headImageView setHidden:YES];
    }
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-20. selfView:_headTipLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithTopYView:_headImageView selfView:_headTipLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithBottomYView:_headImageView selfView:_headTipLabel superView:_maskView];
    
    if (headTipTitle && [headTipTitle length]) {
        [_headTipLabel setText:headTipTitle];
        CGFloat width = [_headTipLabel sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        [JOAutoLayout autoLayoutWithWidth:width selfView:_headTipLabel superView:_maskView];
    }else{
        
        [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_headTipLabel superView:_maskView];
        [_headTipLabel setHidden:YES];
    }
    
    [JOAutoLayout autoLayoutWithLeftView:_headImageView distance:0. selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithTopYView:_headImageView selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithBottomYView:_headImageView selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithRightView:_headTipLabel distance:0. selfView:_headLabel superView:_maskView];
    
    [_headLabel setText:JOConvertStringToNormalString(headTitle)];
}

+ (MIABaseCellHeadView *)cellHeadViewWithImage:(UIImage *)image
                                         title:(NSString *)title
                                      tipTitle:(NSString *)tipTitle
                                         frame:(CGRect)frame
                                 cellColorType:(BaseCellHeadColorType)type{

    MIABaseCellHeadView *headView = [[MIABaseCellHeadView alloc] initWithFrame:frame];
    [headView setHeadImage:image headTitle:title headTipTitle:tipTitle baseCellColorType:type];
    
    return headView;
}

@end
