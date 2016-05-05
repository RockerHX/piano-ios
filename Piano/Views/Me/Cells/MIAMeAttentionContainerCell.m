//
//  MIAMeAttentionContainerCell.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMeAttentionContainerCell.h"
#import "MIAMeAttentionContainerView.h"

static CGFloat const kContentViewLeftSpaceDistance = 20.;
static CGFloat const kContentViewTopSpaceDistance = 10.;
static CGFloat const kContentViewItemSpaceDistance = 25.;

@interface MIAMeAttentionContainerCell(){
    
    CGFloat cellWidth;
}

@property (nonatomic, strong) UIView *cellContentView;

@end

@implementation MIAMeAttentionContainerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self createContentView];
    }
    return self;
}

- (void)createContentView{
    
    self.cellContentView = [UIView newAutoLayoutView];
    [self.contentView addSubview:_cellContentView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewLeftSpaceDistance selfView:_cellContentView superView:self.contentView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-kContentViewLeftSpaceDistance selfView:_cellContentView superView:self.contentView];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewTopSpaceDistance selfView:_cellContentView superView:self.contentView];
    [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewTopSpaceDistance selfView:_cellContentView superView:self.contentView];
}

- (void)setCellWidth:(CGFloat )width{
    
    cellWidth = width;
}

- (void)setMeAttentionConatinerData:(NSArray *)dataArray{
    
    if ([dataArray count] > 4 || [dataArray count] < 1) {
        [JOFException exceptionWithName:@"MIAMeAttentionPromptCell exception" reason:@"DataArray 数据源有问题,count只能在1~4的之间"];
    }else{
        
        CGFloat viewWidth = (cellWidth - 2*kContentViewLeftSpaceDistance - 2*kContentViewItemSpaceDistance)/3.;
        
        for (int i = 0; i < [dataArray count]; i++) {
            
            MIAMeAttentionContainerView *containerView = [self createAttentionPromptViewWithData:nil];
            [containerView setTag:i+1];
            [_cellContentView addSubview:containerView];
            
            [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:containerView superView:_cellContentView];
            [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:containerView superView:_cellContentView];
            [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:containerView superView:_cellContentView];
            
            if (i == 0) {
                [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:containerView superView:_cellContentView];
            }else{
                
                UIView *lastView = [_cellContentView viewWithTag:i];
                [JOAutoLayout autoLayoutWithLeftView:lastView distance:kContentViewItemSpaceDistance selfView:containerView superView:_cellContentView];
            }
        }
    }
}

- (MIAMeAttentionContainerView *)createAttentionPromptViewWithData:(id)data{
    
    MIAMeAttentionContainerView *meAttentionContainerView = [MIAMeAttentionContainerView newAutoLayoutView];
    [meAttentionContainerView setShowData:nil];
    return meAttentionContainerView;
}

@end
