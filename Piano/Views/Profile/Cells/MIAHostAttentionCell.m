//
//  MIAHostAttentionCell.m
//  Piano
//
//  Created by 刘维 on 16/6/12.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAHostAttentionCell.h"
#import "MIAHostAttentionView.h"

CGFloat const kAttentionViewItemSpaceDistance = 25.; //每个元素间的间距 水平方向
CGFloat const kAttentionViewItemVerticalSpaceDistance = 20.;//竖直方向 元素的间距大小

@interface MIAHostAttentionCell(){

    CGFloat cellWidth;
}

@property (nonatomic, copy) NSArray *attentionArray;

@property (nonatomic, strong) MIAHostAttentionView *leftAttentionView;
@property (nonatomic, strong) MIAHostAttentionView *leftMidAttentionView;
@property (nonatomic, strong) MIAHostAttentionView *rightMidAttentionView;
@property (nonatomic, strong) MIAHostAttentionView *rightAttentionView;

@end

@implementation MIAHostAttentionCell

- (void)setCellWidth:(CGFloat )width{
    
    cellWidth = width;
    [self setBackgroundColor:JORGBCreate(0., 0., 0, 0.4)];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.cellContentView  setBackgroundColor:[UIColor clearColor]];
}

//不包含图片的高度
- (CGFloat)getAttentionViewHeight{

    UILabel *label1 = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_Host_Attention_Title]];
    [label1 setText:@" "];
    CGFloat height1 = [label1 sizeThatFits:JOMAXSize].height;
    
    return kAttentionImageToTitleSpaceDistance+ height1;
}

- (void)createAttentionPromptCellContentView{
    
    CGFloat viewWidth = (cellWidth - kContentViewRightSpaceDistance -kContentViewLeftSpaceDistance -kContentViewInsideLeftSpaceDistance - kContentViewInsideRightSpaceDistance - 3*kAttentionViewItemSpaceDistance)/4.;

    
    if (!self.leftAttentionView) {
        //左一
        self.leftAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_leftAttentionView setAttentionViewWidth:viewWidth];
        [_leftAttentionView setTag:1];
        [self.cellContentView addSubview:_leftAttentionView];
        
        [_leftAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_leftAttentionView layoutBottom:-kContentViewInsideBottomSpaceDistance*2 layoutItemHandler:nil];
        [_leftAttentionView layoutWidth:viewWidth layoutItemHandler:nil];
        [_leftAttentionView layoutLeft:kContentViewLeftSpaceDistance layoutItemHandler:nil];
        
        //左二
        self.leftMidAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_leftMidAttentionView setAttentionViewWidth:viewWidth];
        [_leftMidAttentionView setTag:2];
        [self.cellContentView addSubview:_leftMidAttentionView];
        
        [_leftMidAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_leftMidAttentionView layoutBottom:-kContentViewInsideBottomSpaceDistance*2 layoutItemHandler:nil];
        [_leftMidAttentionView layoutWidth:viewWidth layoutItemHandler:nil];
        [_leftMidAttentionView layoutLeftView:_leftAttentionView distance:kAttentionViewItemSpaceDistance layoutItemHandler:nil];
        
        //左三
        self.rightMidAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_rightMidAttentionView setAttentionViewWidth:viewWidth];
        [_rightMidAttentionView setTag:3];
        [self.cellContentView addSubview:_rightMidAttentionView];
        
        [_rightMidAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_rightMidAttentionView layoutBottom:-kContentViewInsideBottomSpaceDistance*2 layoutItemHandler:nil];
        [_rightMidAttentionView layoutWidth:viewWidth layoutItemHandler:nil];
        [_rightMidAttentionView layoutLeftView:_leftMidAttentionView distance:kAttentionViewItemSpaceDistance layoutItemHandler:nil];
        
        //左四
        self.rightAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_rightAttentionView setAttentionViewWidth:viewWidth];
        [_rightAttentionView setTag:4];
        [self.cellContentView addSubview:_rightAttentionView];
        
        [_rightAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_rightAttentionView layoutBottom:-kContentViewInsideBottomSpaceDistance*2 layoutItemHandler:nil];
        [_rightAttentionView layoutWidth:viewWidth layoutItemHandler:nil];
        [_rightAttentionView layoutLeftView:_rightMidAttentionView distance:kAttentionViewItemSpaceDistance layoutItemHandler:nil];
    }
}

- (void)setCellData:(id)data{
    
    if ([data isKindOfClass:[NSArray class]]) {
        
        if ([data count] > 4 || [data count] < 1) {
            [JOFException exceptionWithName:@"MIAMeAttentionPromptCell exception" reason:@"DataArray 数据源有问题,count只能在1~4的之间"];
        }else{
            
            self.attentionArray = nil;
            self.attentionArray = [data copy];
            
            [self createAttentionPromptCellContentView];
            
            [_leftAttentionView setHidden:YES];
            [_leftMidAttentionView setHidden:YES];
            [_rightMidAttentionView setHidden:YES];
            [_rightAttentionView setHidden:YES];
            
            for (int i = 0; i < [_attentionArray count]; i++) {
                
                MIAHostAttentionView *attentionView = [self.cellContentView viewWithTag:i+1];
                [attentionView setShowData:[data objectAtIndex:i]];
                [attentionView setHidden:NO];
            }
        }
    }else{
    
        [JOFException exceptionWithName:@"MIAMeAttentionPromptCell exception" reason:@"data 必须是NSArray类型."];
    }
}

- (void)setHostAttentionTopState:(BOOL)state{

    if (state) {

        [_leftAttentionView layoutTop:5. layoutItemHandler:nil];
        [_leftMidAttentionView layoutTop:5. layoutItemHandler:nil];
        [_rightMidAttentionView layoutTop:5. layoutItemHandler:nil];
        [_rightAttentionView layoutTop:5. layoutItemHandler:nil];
        
    }else{
        
        [_leftAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_leftMidAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_rightMidAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
        [_rightAttentionView layoutTop:kContentViewInsideTopSpaceDistance*2 layoutItemHandler:nil];
    }
}

@end
