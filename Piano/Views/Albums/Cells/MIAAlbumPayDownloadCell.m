//
//  MIAAlbumPayDownloadCell.m
//  Piano
//
//  Created by 刘维 on 16/5/10.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumPayDownloadCell.h"
#import "JOBaseSDK.h"

static NSString *const kPayButtonTitle = @"打赏,下载高品质版";

static CGFloat const kPayButtonHeight = 30.;

@interface MIAAlbumPayDownloadCell()

@property (nonatomic, strong) UIButton *payButton;

@end

@implementation MIAAlbumPayDownloadCell

- (void)setCellWidth:(CGFloat)width{
    
    
}

- (void)createPayButton{

    self.payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_payButton setBackgroundColor:JORGBSameCreate(30.)];
    [[_payButton layer] setCornerRadius:kPayButtonHeight/2.];
    [[_payButton layer] setMasksToBounds:YES];
    [self.cellContentView addSubview:_payButton];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:_payButton superView:self];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:_payButton superView:self];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance selfView:_payButton superView:self];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kContentViewInsideRightSpaceDistance selfView:_payButton superView:self];
}

- (void)setCellData:(id)data{

    
}

@end
