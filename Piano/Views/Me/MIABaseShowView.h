//
//  MIABaseCellView.h
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOBaseSDK.h"

@interface MIABaseShowView : UIView

@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UILabel *showTitleLabel;
@property (nonatomic, strong) UILabel *showTipLabe;

- (void)updateViewLayout;

- (void)setShowData:(id)data;

@end
