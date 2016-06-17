//
//  HXAlertBanner.h
//  mia
//
//  Created by miaios on 15/10/21.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXAlertBanner : UIView

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (nonatomic, assign) CGFloat height;


+ (instancetype)showWithMessage:(NSString *)message tap:(void(^)(void))tap;
+ (instancetype)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration tap:(void(^)(void))tap;

- (void)showWithMessage:(NSString *)message tap:(void(^)(void))tap;
- (void)showWithMessage:(NSString *)message duration:(NSTimeInterval)duration tap:(void(^)(void))tap;

- (void)hidden;

@end
