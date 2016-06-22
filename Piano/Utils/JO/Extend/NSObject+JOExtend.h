//
//  NSObject+JOExtend.h
//  JOProjectBaseSDK
//
//  Created by 刘维 on 16/3/18.
//  Copyright © 2016年 刘维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JOMacro.h"

@interface NSObject (JOThreadPerformExtend)

/**
 *  执行一个SEL,可以传入多个参数。注意保持SEL里面的方法参数的数量与后面给定的参数的一致性(个数,参数类型)
 */
- (id)JOPerformSelector:(SEL)selector arguments:(id)parameter,...;
- (id)JOPerformSelector:(SEL)selector afterDelay:(NSTimeInterval)delay arguments:(id)parameter,...;
- (id)JOPerformSelectorOnMainThread:(SEL)selector waitUntilDone:(BOOL)wait arguments:(id)parameter,...;
- (id)JOPerformSelector:(SEL)selector onThread:(NSThread *)thr  waitUntilDone:(BOOL)wait arguments:(id)parameter,...;
- (id)JOPerformSelectorInBackground:(SEL)selector arguments:(id)parameter,...;

@end

@interface NSObject(JOSwizzle)

#pragma mark - Swizzling 交换两个方法的IMP

/**
 *  交换同一个类的对象方法中两个方法的IMP.
 *
 *  @param sel    对象方法SEL.
 *  @param newSel 需要交换的对象方法SEL.
 *
 *  @return 交换成功的状态.
 */
+ (BOOL)JOSwizzleInstanceMethod:(SEL)sel withMehtod:(SEL)newSel;

/**
 *  交换类方法中两个方法的IMP
 *
 *  @param sel    类方法SEL.
 *  @param newSel 需要交换的类方法SEL.
 *
 *  @return 交换成功的状态.
 */
+ (BOOL)JOSwizzleClassMethod:(SEL)sel withMehtod:(SEL)newSel;

@end

@interface NSObject(JORuntimeExtend)

/**
 *  获取该类中所有的实例方法的SEL
 *
 *  @return 所有SEL的方法的集合:数组中存的是字符串的对象(NSStringFromSelector).
 */
+ (NSArray *)JOGetAllSelector;

/**
 *  获取该类中所有property的属性(包括父类的,NSObject除外).
 *
 *  @return 所有的property属性名的字符串的array.
 */
+ (NSArray *)JOGetAllProperty;

/**
 *  获取该类中所有的property的属性名跟值的键值对(包括父类的,NSObject除外)
 *
 *  @return 所有该类中的属性值作为key,值作为value的字典类型(如果value为nil的话,则不会在其中)
 */
- (NSDictionary *)JOGetAllPropertyDictionary;

/**
 *  获取本类中所有的property属性.
 *
 *  @return 所有的property属性的字符串的array.
 */
+ (NSArray *)JOGetProperty;

/**
 *  获取本类中所有的属性跟值的键值对.
 *
 *  @return 本类中所有的属性跟值的键值对.
 */
- (NSDictionary *)JOGetProjectDictionary;

/**
 *  获取该类中所有的变量名
 *
 *  @return 所有未声明成Property的变量名和已经申明成Property的变量名的：e.g:(_name),字符串类型
 */
+ (NSArray *)JOGetAllIvar;

/**
 *  所有类中所支持的协议.
 *
 *  @return 所有该类中所支持的协议的字符串.
 */
+ (NSArray *)JOGetAllProtocol;

@end




