//
//  MIABaseCellHeadView.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseCellHeadView.h"
#import "MIAFontManage.h"
#import "JOBaseSDK.h"

CGFloat const kBaseCellHeadViewHeight = 35.;

@interface MIABaseCellHeadView()

@end

@implementation MIABaseCellHeadView

- (void)createView{
    
    self.backgroundView = [UIView newAutoLayoutView];
    [_backgroundView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:_backgroundView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_backgroundView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_backgroundView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_backgroundView superView:self];
    [JOAutoLayout autoLayoutWithHeight:kBaseCellHeadViewHeight-10. selfView:_backgroundView superView:self];
    
    self.maskView = [UIView newAutoLayoutView];
    [self addSubview:_maskView];
    
    self.headImageButtonView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headImageButtonView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    [_headImageButtonView setContentMode:UIViewContentModeScaleAspectFit];
    [_maskView addSubview:_headImageButtonView];
    
    self.headLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Cell_Title]];
    [_headLabel setBackgroundColor:[UIColor clearColor]];
    [_headLabel setTextAlignment:NSTextAlignmentLeft];
    [_maskView addSubview:_headLabel];
    
    self.headTipLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Cell_Tip]];
    [_headTipLabel setBackgroundColor:[UIColor clearColor]];
    [_headTipLabel setTextAlignment:NSTextAlignmentLeft];
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
            [_maskView setBackgroundColor:[UIColor whiteColor]];
            [_headLabel setTextColor:[UIColor blackColor]];
            [self setBackgroundColor:[UIColor blackColor]];
        }else if(colorType == BaseCellHeadColorTypeBlack){
            [_maskView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
            [_backgroundView setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
            [_headLabel setTextColor:[UIColor whiteColor]];
            [self setBackgroundColor:[UIColor blackColor]];
            
        }else if(colorType == BaseCellHeadColorTypeSpecial){
        
            [self setBackgroundColor:[UIColor clearColor]];
            [_maskView setBackgroundColor:[UIColor whiteColor]];
            [_headLabel setTextColor:[UIColor blackColor]];
            
            [JOAutoLayout removeAutoLayoutWithHeightSelfView:_backgroundView superView:self];
            [JOAutoLayout autoLayoutWithHeight:kBaseCellHeadViewHeight selfView:_backgroundView superView:self];
        }
        
        objc_setAssociatedObject(self, _cmd, @"only", OBJC_ASSOCIATION_RETAIN);
    }
    
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_maskView superView:self];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headImageButtonView superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headLabel superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headTipLabel superView:_maskView];
    
//    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(10., 0., 0., 0.) selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithHeight:kBaseCellHeadViewHeight-10 selfView:_maskView superView:self];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_headImageButtonView superView:_maskView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:10. selfView:_headImageButtonView superView:_maskView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_headImageButtonView superView:_maskView];
    if (image) {
//        [_headImageButtonView setImage:image];
        [_headImageButtonView setImage:image forState:UIControlStateNormal];
        [JOAutoLayout autoLayoutWithWidthEqualHeightWithselfView:_headImageButtonView superView:_maskView];
        [_headImageButtonView setHidden:NO];
    }else{
        [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_headImageButtonView superView:_maskView];
        [_headImageButtonView setHidden:YES];
    }
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_headTipLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithTopYView:_headImageButtonView selfView:_headTipLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithBottomYView:_headImageButtonView selfView:_headTipLabel superView:_maskView];
    
    if (headTipTitle && [headTipTitle length]) {
        [_headTipLabel setText:headTipTitle];
        CGFloat width = [_headTipLabel sizeThatFits:JOMAXSize].width;
        [JOAutoLayout autoLayoutWithWidth:width selfView:_headTipLabel superView:_maskView];
        [_headTipLabel setHidden:NO];
    }else{
        
        [JOAutoLayout autoLayoutWithWidth:CGFLOAT_MIN selfView:_headTipLabel superView:_maskView];
        [_headTipLabel setHidden:YES];
    }
    
    [JOAutoLayout autoLayoutWithLeftView:_headImageButtonView distance:4. selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithTopYView:_headImageButtonView selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithBottomYView:_headImageButtonView selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithRightView:_headTipLabel distance:0. selfView:_headLabel superView:_maskView];
    
    [_headLabel setText:JOConvertStringToNormalString(headTitle)];
}

//- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event{
//
//    return
//}

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
