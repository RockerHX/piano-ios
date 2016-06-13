//
//  MIASettingCell.m
//  Piano
//
//  Created by 刘维 on 16/6/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASettingCell.h"
#import "MIASettingCellView.h"
#import "JOBaseSDK.h"

@interface MIASettingCell()

@property (nonatomic, strong) MIASettingCellView *cellView;

@end

@implementation MIASettingCell

- (void)createCellView{

    if (!self.cellView) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.cellContentView  setBackgroundColor:[UIColor clearColor]];
        
        [JOAutoLayout removeAllAutoLayoutWithSelfView:self.cellContentView superView:self.contentView];
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:self.cellContentView superView:self.contentView];
        
        self.cellView = [MIASettingCellView newAutoLayoutView];
        [_cellView setBackgroundColor:JORGBCreate(0., 0., 0., 0.4)];
        [self.cellContentView addSubview:_cellView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., -0.5, 0.) selfView:_cellView superView:self.cellContentView];
    }
}

- (void)setSettingCellTitle:(NSString *)title contnet:(NSString *)content{

    [self createCellView];
    [_cellView setTitle:title content:content];
}

- (void)setCellAccessoryImage:(UIImage *)image{

    [self createCellView];
    [_cellView setAccessoryImage:image];
}

- (void)setCellTitleAttributedText:(NSAttributedString *)attributedTitle{

    [self createCellView];
    [_cellView setTitleAttributedText:attributedTitle];
}

@end
