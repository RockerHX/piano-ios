//
//  MIAAlbumCoverCell.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumCoverCell.h"
#import "UIImageView+WebCache.h"
#import "JOBaseSDK.h"

@interface MIAAlbumCoverCell()

@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation MIAAlbumCoverCell

- (void)setCellWidth:(CGFloat)width{

    
}

- (void)createCoverImageView{

    if (!self.coverImageView) {
        self.coverImageView = [UIImageView newAutoLayoutView];
        [_coverImageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.cellContentView addSubview:_coverImageView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_coverImageView superView:self.cellContentView];
    }
}

- (void)setCellData:(id)data{

    if ([data isKindOfClass:[NSString class]]) {
        [self createCoverImageView];
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:data] placeholderImage:nil];
    }else{
    
        [JOFException exceptionWithName:@"MIAAlbumCoverCell exception!" reason:@"data要为封面的URL地址的字符串"];
    }
}

@end
