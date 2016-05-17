//
//  MIAPaymentBarView.h
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PaymentBarButtonItemType) {

    PaymentBarButtonItemType_Pop, //pop类型
    PaymentBarButtonItemType_PayHistory, //消费记录类型
};

/**
 *  按钮的点击事件的block.
 *
 *  @param type PaymentBarButtonItemType.
 */
typedef void(^PaymentBarButtonClickBlock) (PaymentBarButtonItemType type);

@interface MIAPaymentBarView : UIView

/**
 *  设置M币的余额
 *
 *  @param mAmount <#mAmount description#>
 */
- (void)setMAmount:(NSString *)mAmount;

/**
 *  设置按钮的点击事件回调.
 *
 *  @param block PaymentBarButtonClickBlock.
 */
- (void)paymentBarButtonClickHandler:(PaymentBarButtonClickBlock)block;

@end
