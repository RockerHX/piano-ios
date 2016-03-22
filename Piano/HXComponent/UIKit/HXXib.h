//
//  HXXib.h
//  Mia
//
//  Created by miaios on 15/12/7.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#define HXXibImplementation \
- (instancetype)initWithFrame:(CGRect)frame { \
    self = [super initWithFrame:frame]; \
    if (self) { \
        [self xibSetup]; \
    } \
    return self; \
} \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder { \
    self = [super initWithCoder:aDecoder]; \
    if (self) { \
        [self xibSetup]; \
    } \
    return self; \
} \
\
- (void)xibSetup { \
    UIView *view = [self loadViewFromNib]; \
    view.frame = self.bounds; \
    [self addSubview:view]; \
} \
\
- (UIView *)loadViewFromNib { \
    UIView *view = nil; \
    @try { \
        NSBundle *bundle = [NSBundle bundleForClass:[self class]]; \
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle]; \
        view = [[nib instantiateWithOwner:self options:nil] firstObject]; \
        view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;\
    } \
    @catch (NSException *exception) { \
        NSLog(@"Load %@ With Nib Error:%@", NSStringFromClass([self class]), exception.reason); \
    } \
    @finally { \
        return view; \
    } \
} \
