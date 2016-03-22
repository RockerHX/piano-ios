//
//  HXThemeManager.m
//
//  Created by RockerHX
//  Copyright (c) Andy Shaw. All rights reserved.
//

#import "HXThemeManager.h"


static NSString *SelectedThemeKey = @"SelectedTheme";


@implementation HXThemeManager

@synthesize themeStyle = _themeStyle;
@synthesize themeColor = _themeColor;

#pragma mark - Init Methods
+ (instancetype)share {
    static HXThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HXThemeManager alloc] init];
    });
    return manager;
}

#pragma mark - Setter And Getter
- (HXThemeStyle)themeStyle {
    HXThemeStyle theme = [[[NSUserDefaults standardUserDefaults] valueForKey:SelectedThemeKey] integerValue];
    return theme;
}

- (void)setThemeStyle:(HXThemeStyle)themeStyle {
    _themeStyle = themeStyle;
    [self applyTheme];
}

- (UIColor *)themeColor {
    return [self themeColorWithStyle:_themeStyle];
}

#pragma mark - Public Methods
- (void)applyTheme {
    [[NSUserDefaults standardUserDefaults] setValue:@(_themeStyle) forKey:SelectedThemeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[UITabBar appearance] setTintColor:self.themeColor];
}

- (UIColor *)themeColorWithStyle:(HXThemeStyle)themeStyle {
    UIColor *color = nil;
    switch (themeStyle) {
        case HXThemeStyleOrange: {
            color = [UIColor colorWithRed:252.0f/255.0f green:139.0f/255.0f blue:69.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeStyleDark: {
            color = [UIColor colorWithRed:242.0f/255.0f green:101.0f/255.0f blue:34.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeStyleGraphical: {
            color = [UIColor colorWithRed:10.0f/255.0f green:10.0f/255.0f blue:10.0f/255.0f alpha:1.0f];
            break;
        }
        case HXThemeStyleBlack: {
            color = [UIColor blackColor];
            break;
        }
            
        default: {
            color = [UIApplication sharedApplication].keyWindow.tintColor;
            break;
        }
    }
    return color;
}

@end
