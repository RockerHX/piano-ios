//
//  MIALabel.h
//  mia
//
//  Created by mia on 14-8-4.
//  Copyright (c) 2014年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class MIALabel;

@protocol MIALabelTouchesDelegate <NSObject>

@optional
- (void)label:(MIALabel *)label touchesWtihTag:(NSInteger)tag;

@end

@interface MIALabel : UILabel



@property (nonatomic, assign) id <MIALabelTouchesDelegate> delegate;


/**
 *  自定义初始化UILabel
 *
 *  @param frame         大小
 *  @param text          文案
 *  @param font          字体
 *  @param textColor     文案颜色
 *  @param textAlignment 文案偏移位置
 *  @param numberLines   显示的行数
 *
 */
- (id)initWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment numberLines:(int)numberLines;


@end
