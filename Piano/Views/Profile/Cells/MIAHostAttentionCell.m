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
    
//    for (UIView *subView in self.cellContentView.subviews) {
//        [subView setHidden:YES];
//        [subView removeFromSuperview];
//    }
    
    if (!self.leftAttentionView) {
//
//        for (int i = 0; i < [_attentionArray count]; i++) {
//            
//            MIAHostAttentionView *hostAttentionView = [MIAHostAttentionView newAutoLayoutView];
//            [hostAttentionView setAttentionViewWidth:viewWidth];
//            [hostAttentionView setTag:i+1];
//            [self.cellContentView addSubview:hostAttentionView];
//            
//            [JOAutoLayout autoLayoutWithSize:JOSize(viewWidth, viewWidth+[self getAttentionViewHeight]) selfView:hostAttentionView superView:self.cellContentView];
//            
//            if (i < 4 ) {
//                //第一排的
//                if(i){
//                    //非第一个
//                    UIView *lastView = [self.cellContentView viewWithTag:i];
//                    [JOAutoLayout autoLayoutWithLeftView:lastView distance:kAttentionViewItemSpaceDistance selfView:hostAttentionView superView:self.cellContentView];
//                    
//                }else{
//                    //第一个
//                    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:hostAttentionView superView:self.cellContentView];
//                }
//                
//                [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance selfView:hostAttentionView superView:self.cellContentView];
//                
//            }else{
//                //第二排的
//                UIView *topView = [self.cellContentView viewWithTag:i-3];
//                [JOAutoLayout autoLayoutWithTopView:topView distance:kAttentionViewItemVerticalSpaceDistance selfView:hostAttentionView superView:self.cellContentView];
//                if (i == 4) {
//                    //第二排第一个
//                    [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewInsideLeftSpaceDistance selfView:hostAttentionView superView:self.cellContentView];
//                }else{
//                    //非第一个
//                    UIView *lastView = [self.cellContentView viewWithTag:i];
//                    [JOAutoLayout autoLayoutWithLeftView:lastView distance:kAttentionViewItemSpaceDistance selfView:hostAttentionView superView:self.cellContentView];
//                }
//            }
//            
//        }
    
        //左一
        self.leftAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_leftAttentionView setAttentionViewWidth:viewWidth];
        [_leftAttentionView setTag:1];
        [self.cellContentView addSubview:_leftAttentionView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance*2 selfView:_leftAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance*2 selfView:_leftAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_leftAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:kContentViewLeftSpaceDistance selfView:_leftAttentionView superView:self.cellContentView];
        
        //左二
        self.leftMidAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_leftMidAttentionView setAttentionViewWidth:viewWidth];
        [_leftMidAttentionView setTag:2];
        [self.cellContentView addSubview:_leftMidAttentionView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance*2 selfView:_leftMidAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance*2 selfView:_leftMidAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_leftMidAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_leftAttentionView distance:kAttentionViewItemSpaceDistance selfView:_leftMidAttentionView superView:self.cellContentView];
        
        //左三
        self.rightMidAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_rightMidAttentionView setAttentionViewWidth:viewWidth];
        [_rightMidAttentionView setTag:3];
        [self.cellContentView addSubview:_rightMidAttentionView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance*2 selfView:_rightMidAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance*2 selfView:_rightMidAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_rightMidAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_leftMidAttentionView distance:kAttentionViewItemSpaceDistance selfView:_rightMidAttentionView superView:self.cellContentView];
        
        //左四
        self.rightAttentionView = [MIAHostAttentionView newAutoLayoutView];
        [_rightAttentionView setAttentionViewWidth:viewWidth];
        [_rightAttentionView setTag:4];
        [self.cellContentView addSubview:_rightAttentionView];
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentViewInsideTopSpaceDistance*2 selfView:_rightAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:-kContentViewInsideBottomSpaceDistance*2 selfView:_rightAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithWidth:viewWidth selfView:_rightAttentionView superView:self.cellContentView];
        [JOAutoLayout autoLayoutWithLeftView:_rightMidAttentionView distance:kAttentionViewItemSpaceDistance selfView:_rightAttentionView superView:self.cellContentView];
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

@end
