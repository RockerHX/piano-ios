//
//  MIANavBarView.h
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮点击的block.
 */
typedef void(^ButtonClickBlock)();

@interface MIANavBarView : UIView

/**
 *  设置NavBar的标题
 *
 *  @param title 标题
 */
- (void)setTitle:(NSString *)title;

/**
 *  获取title的Label.
 *
 *  @return Label
 */
- (UILabel *)navBarTitleLabel;

/**
 *  设置左边按钮的显示.
 *
 *  @param buttonTitle 按钮显示的东西.
 */
- (void)setLeftButtonTitle:(NSString *)buttonTitle titleColor:(UIColor *)color;
- (void)setLeftButtonImageName:(NSString *)imageName;
/**
 *  左边的按钮.
 *
 *  @return UIButton.
 */
- (UIButton *)navBarLeftButton;

/**
 *  设置右边按钮的显示.
 *
 *  @param buttonTitle 按钮显示的东西.
 */
- (void)setRightButtonTitle:(NSString *)buttonTitle titleColor:(UIColor *)color;
- (void)setRightButtonImageName:(NSString *)imageName;

/**
 *  右边的按钮.
 *
 *  @return UIButton.
 */
- (UIButton *)navBarRightButton;


/**
 *  根据这个决定左右的按钮是否显示.如果设置为nil,则会隐藏相应的按钮.
 *
 *  @param leftButtonClickBlock  ButtonClickBlock
 *  @param rightButtonClickBlock ButtonClickBlock
 */
- (void)navBarLeftClickHanlder:(ButtonClickBlock)leftClickBlock rightClickHandler:(ButtonClickBlock)rightClickBlock;

@end
