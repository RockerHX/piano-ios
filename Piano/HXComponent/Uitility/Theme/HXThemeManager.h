//
//  HXThemeManager.h
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HXThemeStyle) {
    HXThemeStyleDefault,
    HXThemeStyleOrange,
    HXThemeStyleDark,
    HXThemeStyleGraphical,
    HXThemeStyleBlack
};


@interface HXThemeManager : NSObject

@property (nonatomic, assign)           HXThemeStyle  themeStyle;
@property (nonatomic, strong, readonly)      UIColor *themeColor;

+ (instancetype)share;

- (void)applyTheme;
- (UIColor *)themeColorWithStyle:(HXThemeStyle)themeStyle;

NS_ASSUME_NONNULL_END

@end
