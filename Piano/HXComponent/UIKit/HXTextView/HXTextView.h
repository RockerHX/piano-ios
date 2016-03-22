//
//  HXTextView.h
//
//  Created by RockerHX.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXTextView;

@protocol HXTextViewDelegate <UITextViewDelegate>

@required
- (void)textViewSizeChanged:(CGSize)size;

@end

@interface HXTextView: UITextView

@property (nonatomic, assign)           IBInspectable  CGFloat  maxLine;
@property (nullable, nonatomic, copy)   IBInspectable NSString *placeholderText;
@property (nullable, nonatomic, strong) IBInspectable  UIColor *placeholderColor;

#if TARGET_INTERFACE_BUILDER
@property (nonatomic) IBInspectable NSInteger  placeholderAlignment;
#else
@property (nonatomic) NSTextAlignment  placeholderAlignment;
#endif

@end