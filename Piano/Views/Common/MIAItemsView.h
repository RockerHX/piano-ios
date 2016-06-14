//
//  MIAItemsView.h
//  Piano
//
//  Created by 刘维 on 16/5/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Item的点击的事件.
 *
 *  @param index     点击的index.
 *  @param itemTitel item的标题.
 */
typedef void(^ItemClickBlock)(NSInteger index, NSString *itemTitel);

@interface MIAItemsView : UIView

/**
 *  设置item的数据.
 *
 *  @param itemArray item的数组.
 */
- (void)setItemArray:(NSArray *)itemArray;

/**
 *  设置item的一些属性.
 *
 *  @param color 颜色.
 *  @param font  字体
 */
- (void)setItemTitleColor:(UIColor *)color titleFont:(UIFont *)font;

/**
 *  设置动画的x的位移.
 *
 *  @param offsetX x的位移.
 */
- (void)setAnimationOffsetX:(CGFloat)offsetX;

/**
 *  设置动画的颜色.
 *
 *  @param color 颜色.
 */
- (void)setAnimationColor:(UIColor *)color;

/**
 *  item的点击回调.
 *
 *  @param block ItemClickBlock.
 */
- (void)itemClickHanlder:(ItemClickBlock)block;

/**
 *  设置Item选中的title的颜色.
 *
 *  @param color 选中的颜色.
 */
- (void)setItemTitleSelectedColor:(UIColor *)color;

/**
 *  设置当前选中的是Item.
 *
 *  @param index 当前的Item
 */
- (void)setCurrentSelectedIndex:(NSInteger)index;

@end
