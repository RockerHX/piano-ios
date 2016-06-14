//
//  MIABaseCellHeadView.h
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BaseCellHeadColorType){

    BaseCellHeadColorTypeWhiter,
    BaseCellHeadColorTypeBlack,
    BaseCellHeadColorTypeSpecial, //针对主播Profile页的特殊情况
};

UIKIT_EXTERN CGFloat const kBaseCellHeadViewHeight;

@interface MIABaseCellHeadView : UIView

@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UILabel *headLabel;
@property (nonatomic, strong) UILabel *headTipLabel;

+ (MIABaseCellHeadView *)cellHeadViewWithImage:(UIImage *)image
                                         title:(NSString *)title
                                      tipTitle:(NSString *)tipTitle
                                         frame:(CGRect)frame
                                 cellColorType:(BaseCellHeadColorType)type;

@end
