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
    
    [_backgroundView layoutLeft:0. layoutItemHandler:nil];
    [_backgroundView layoutRight:0. layoutItemHandler:nil];
    [_backgroundView layoutBottom:0. layoutItemHandler:nil];
    [_backgroundView layoutHeight:kBaseCellHeadViewHeight-10. layoutItemHandler:nil];
    
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
            
            [_backgroundView layoutHeight:kBaseCellHeadViewHeight layoutItemHandler:nil];
        }
        
        objc_setAssociatedObject(self, _cmd, @"only", OBJC_ASSOCIATION_RETAIN);
    }
    
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_maskView superView:self];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headImageView superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headLabel superView:_maskView];
    [JOAutoLayout removeAllAutoLayoutWithSelfView:_headTipLabel superView:_maskView];
    
    [_maskView layoutLeft:10. layoutItemHandler:nil];
    [_maskView layoutRight:-10. layoutItemHandler:nil];
    [_maskView layoutBottom:0. layoutItemHandler:nil];
    [_maskView layoutHeight:kBaseCellHeadViewHeight-10 layoutItemHandler:nil];
    
    [_headImageView layoutLeft:10. layoutItemHandler:nil];
    [_headImageView layoutCenterYView:_headLabel layoutItemHandler:nil];
    if (image) {
        [_headImageView setImage:image];
        [_headImageView layoutSize:image.size layoutItemHandler:nil];
        [_headImageView setHidden:NO];
        [_headLabel layoutLeftView:_headImageView distance:5. layoutItemHandler:nil];
    }else{
        
        [_headImageView layoutSize:JOSize(CGFLOAT_MIN, CGFLOAT_MIN) layoutItemHandler:nil];
        [_headImageView setHidden:YES];
        [_headLabel layoutLeftView:_headImageView distance:0. layoutItemHandler:nil];
    }
    
    [_headTipLabel layoutRight:-10. layoutItemHandler:nil];
    [_headTipLabel layoutTopYView:_headLabel distance:0. layoutItemHandler:nil];
    
    if (headTipTitle && [headTipTitle length]) {
        [_headTipLabel setText:headTipTitle];
        CGFloat width = [_headTipLabel sizeThatFits:JOMAXSize].width;
        
        [_headTipLabel layoutWidth:width layoutItemHandler:nil];
        [_headTipLabel layoutHeight:[_headTipLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
        
        [_headTipLabel setHidden:NO];
    }else{
        
        [_headTipLabel layoutSize:JOSize(CGFLOAT_MIN, CGFLOAT_MIN) layoutItemHandler:nil];
        [_headTipLabel setHidden:YES];
    }
    
    [_headLabel setText:JOConvertStringToNormalString(headTitle)];
    
    [_headLabel layoutBottom:0. layoutItemHandler:nil];
    [_headLabel layoutHeight:[_headLabel sizeThatFits:JOMAXSize].height layoutItemHandler:nil];
    [_headLabel layoutRightView:_headTipLabel distance:0. layoutItemHandler:nil];
}

- (void)setImageSize:(CGSize)size{

    [_headImageView layoutSize:size layoutItemHandler:nil];
    
}

- (void)setImageOffsetX:(CGFloat)offsetX{
    
    [_headImageView layoutLeft:10+offsetX layoutItemHandler:nil];
    
    
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
