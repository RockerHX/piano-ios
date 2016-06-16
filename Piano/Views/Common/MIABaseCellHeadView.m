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

CGFloat const kBaseCellHeadViewHeight = 40.;

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
    
    self.headImageView = [UIImageView newAutoLayoutView];
    [_maskView addSubview:_headImageView];
    
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
            [_maskView setBackgroundColor:[UIColor clearColor]];
            [_backgroundView setBackgroundColor:JORGBCreate(0., 0., 0., 0.4)];
            [_headLabel setTextColor:[UIColor whiteColor]];
            [self setBackgroundColor:[UIColor clearColor]];
            
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
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headImageView superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headLabel superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headTipLabel superView:_maskView];
    
//    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(10., 0., 0., 0.) selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_maskView superView:self];
    [JOAutoLayout autoLayoutWithHeight:kBaseCellHeadViewHeight-10 selfView:_maskView superView:self];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:_headImageView superView:_maskView];
    [JOAutoLayout autoLayoutWithCenterYWithView:_headLabel selfView:_headImageView superView:_maskView];
    if (image) {
        [_headImageView setImage:image];
        [JOAutoLayout autoLayoutWithSize:image.size selfView:_headImageView superView:_maskView];
        [_headImageView setHidden:NO];
        [JOAutoLayout autoLayoutWithLeftView:_headImageView distance:5. selfView:_headLabel superView:_maskView];
    }else{
        
        [JOAutoLayout autoLayoutWithSize:JOSize(CGFLOAT_MIN, CGFLOAT_MIN) selfView:_headImageView superView:_maskView];
        [_headImageView setHidden:YES];
        [JOAutoLayout autoLayoutWithLeftView:_headImageView distance:0. selfView:_headLabel superView:_maskView];
    }
    
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:_headTipLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithTopYView:_headLabel selfView:_headTipLabel superView:_maskView];
    if (headTipTitle && [headTipTitle length]) {
        [_headTipLabel setText:headTipTitle];
        CGFloat width = [_headTipLabel sizeThatFits:JOMAXSize].width;
        [JOAutoLayout autoLayoutWithWidth:width selfView:_headTipLabel superView:_maskView];
        [JOAutoLayout autoLayoutWithHeight:[_headTipLabel sizeThatFits:JOMAXSize].height selfView:_headTipLabel superView:_maskView];
        [_headTipLabel setHidden:NO];
    }else{
        [JOAutoLayout autoLayoutWithSize:JOSize(CGFLOAT_MIN, CGFLOAT_MIN) selfView:_headTipLabel superView:_maskView];
        [_headTipLabel setHidden:YES];
    }
    
    [_headLabel setText:JOConvertStringToNormalString(headTitle)];
    
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithHeight:[_headLabel sizeThatFits:JOMAXSize].height selfView:_headLabel superView:_maskView];
    [JOAutoLayout autoLayoutWithRightView:_headTipLabel distance:0. selfView:_headLabel superView:_maskView];
}

- (void)setImageSize:(CGSize)size{

    [JOAutoLayout removeAutoLayoutWithSizeSelfView:_headImageView superView:_maskView];
    
    [JOAutoLayout autoLayoutWithSize:size selfView:_headImageView superView:_maskView];
}

- (void)setImageOffsetX:(CGFloat)offsetX{

    [JOAutoLayout removeAutoLayoutWithLeftSelfView:_headImageView superView:_maskView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:10+offsetX selfView:_headImageView superView:_maskView];
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

+ (MIABaseCellHeadView *)cellHeadViewWithImage:(UIImage *)image
                                         title:(NSString *)title
                                      tipTitle:(NSString *)tipTitle
                                         frame:(CGRect)frame
                                  imageAddSize:(CGFloat)size
                                 cellColorType:(BaseCellHeadColorType)type{

    MIABaseCellHeadView *headView = [[MIABaseCellHeadView alloc] initWithFrame:frame];
    [headView setHeadImage:image headTitle:title headTipTitle:tipTitle baseCellColorType:type];
    
    if (image) {
        CGSize imageSize = [image size];
        [headView setImageSize:JOSize(imageSize.width+size, imageSize.height+size)];
    }
    return headView;
}

+ (MIABaseCellHeadView *)cellHeadViewWithImage:(UIImage *)image
                                         title:(NSString *)title
                                      tipTitle:(NSString *)tipTitle
                                         frame:(CGRect)frame
                                  imageOffsetX:(CGFloat)offsetX
                                 cellColorType:(BaseCellHeadColorType)type{

    MIABaseCellHeadView *headView = [[MIABaseCellHeadView alloc] initWithFrame:frame];
    [headView setHeadImage:image headTitle:title headTipTitle:tipTitle baseCellColorType:type];
    
    if (image) {
        [headView setImageOffsetX:offsetX];
    }
    return headView;
}

@end
