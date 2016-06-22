//
//  MIABaseTableViewCell.m
//  Piano
//
//  Created by 刘维 on 16/5/6.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIABaseTableViewCell.h"

CGFloat const kContentViewLeftSpaceDistance = 10.;
CGFloat const kContentViewRightSpaceDistance = 10.;
CGFloat const kContentViewTopSpaceDistance = 0.;
CGFloat const kContentViewBottomSpaceDistance = 0.;

CGFloat const kContentViewInsideLeftSpaceDistance = 10.;
CGFloat const kContentViewInsideRightSpaceDistance = 10.;
CGFloat const kContentViewInsideTopSpaceDistance = 10.;
CGFloat const kContentViewInsideBottomSpaceDistance = 10.;

@implementation MIABaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView setBackgroundColor:[UIColor blackColor]];
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    
    self.cellContentView = [UIView newAutoLayoutView];
    [self.contentView addSubview:_cellContentView];
    
//    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewLeftSpaceDistance selfView:_cellContentView superView:self.contentView];
//    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kContentViewRightSpaceDistance selfView:_cellContentView superView:self.contentView];
//    [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewTopSpaceDistance selfView:_cellContentView superView:self.contentView];
//    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewBottomSpaceDistance selfView:_cellContentView superView:self.contentView];
    
    [_cellContentView layoutLeft:kContentViewLeftSpaceDistance layoutItemHandler:nil];
    [_cellContentView layoutRight:-kContentViewRightSpaceDistance layoutItemHandler:nil];
    [_cellContentView layoutTop:kContentViewTopSpaceDistance layoutItemHandler:nil];
    [_cellContentView layoutBottom:-kContentViewBottomSpaceDistance layoutItemHandler:nil];
}

- (void)setCellWidth:(CGFloat )width{}

- (void)setCellData:(id)data{}

@end
