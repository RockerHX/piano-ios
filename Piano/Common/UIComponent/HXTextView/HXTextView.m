//
//  HXTextView.m
//
//  Created by RockerHX.
//  Copyright (c) 2015年 Andy Shaw. All rights reserved.
//

#import "HXTextView.h"

@implementation HXTextView {
    BOOL _firstLoad;
    id <HXTextViewDelegate>_delegate;
    
    CGFloat   _maxHeight;
    NSString *_placeholderText;
    UIColor  *_placeholderColor;
    UILabel  *_placeholderLabel;
    NSTextAlignment _placeholderAlignment;
}

#pragma mark - Init Methods
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self initConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)initConfigure {
    self.text = @"";
    _firstLoad = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange:) name:UITextViewTextDidChangeNotification object:self];
}

- (void)viewConfigure {
    if (!self.backgroundColor) {
        self.backgroundColor = [UIColor clearColor];
    }
    _placeholderColor = [UIColor lightGrayColor];
}

#pragma mark - DrawRect Methods
- (void)drawRect:(CGRect)rect {
    if ([_placeholderText length]) {
        if (!_placeholderLabel) {
            _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8.0f, 8.0f, rect.size.width - 16.0f, 18.0f)];
            _placeholderLabel.backgroundColor = [UIColor clearColor];
            _placeholderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            _placeholderLabel.numberOfLines = 0;
            _placeholderLabel.textAlignment = _placeholderAlignment;
            _placeholderLabel.font = self.font;
            [self addSubview:_placeholderLabel];
        }
        
        _placeholderLabel.text      = _placeholderText;
        _placeholderLabel.textColor = _placeholderColor;
    }
    
    [self layoutGUI];
    
    [super drawRect:rect];
}

#pragma mark - Setters And Getter
- (void)setDelegate:(id<UITextViewDelegate>)delegate {
    _delegate = (id<HXTextViewDelegate>)delegate;
}

- (id<UITextViewDelegate>)delegate {
    return (id<HXTextViewDelegate>)_delegate;
}

- (void)setMaxLine:(CGFloat)maxLine {
    _maxLine = maxLine;
    
    CGRect textRect = [self.layoutManager usedRectForTextContainer:self.textContainer];
    _maxHeight = maxLine * textRect.size.height;
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    _placeholderLabel.textColor = placeholderColor;
    [self setNeedsDisplay];
}

- (UIColor *)placeholderColor {
    return _placeholderColor;
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    _placeholderLabel.text = placeholderText;
    [self setNeedsDisplay];
}

- (NSString *)placeholderText {
    return _placeholderText;
}

- (void)setPlaceholderAlignment:(NSTextAlignment)placeholderAlignment {
    _placeholderAlignment = placeholderAlignment;
    _placeholderLabel.textAlignment = placeholderAlignment;
    [self setNeedsDisplay];
}

- (NSTextAlignment)placeholderAlignment {
    return _placeholderAlignment;
}

#pragma mark - Event Response
- (void)textDidChange:(NSNotification *)notification {
    if (notification.object == self) {
        [self updateLayout];
        [self layoutGUI];
    }
}

#pragma mark - LayoutGUI Methods
- (void)layoutGUI {
    _placeholderLabel.alpha = [self.text length] ? 0.0f : 1.0f;
}

- (void)updateLayout {
    [self invalidateIntrinsicContentSize];
    [self scrollRangeToVisible:self.selectedRange];
}

#pragma mark - Parent Methods
- (void)setText:(NSString *)text {
    [super setText:text];
    
    if (_maxHeight > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineHeightMultiple = 100.0f;
        NSString *string = text;
        NSDictionary *ats = @{NSFontAttributeName: self.font,
                              NSParagraphStyleAttributeName: paragraphStyle};
        self.attributedText = [[NSAttributedString alloc] initWithString:string attributes:ats];
    }
    
    [self updateLayout];
    [self layoutGUI];
}

- (CGSize)intrinsicContentSize {
    CGRect textRect = [self.layoutManager usedRectForTextContainer:self.textContainer];
    CGFloat height = [self correctHeightWithHeight:textRect.size.height] + self.textContainerInset.top + self.textContainerInset.bottom;
    CGSize size = CGSizeMake(UIViewNoIntrinsicMetric, height);
    [self performSelector:@selector(excuteTextViewSizeChangedDelegateMethods:) withObject:@(height) afterDelay:0.05f];
    
    return size;
}

#pragma mark - Private Methods
- (void)excuteTextViewSizeChangedDelegateMethods:(NSNumber *)height {
    if (_delegate && [_delegate respondsToSelector:@selector(textViewSizeChanged:)] && !_firstLoad) {
        [_delegate textViewSizeChanged:CGSizeMake(UIViewNoIntrinsicMetric, height.doubleValue)];
    }
    _firstLoad = NO;
}

- (CGFloat)correctHeightWithHeight:(CGFloat)height {
    if (_maxHeight <= 0) {
        return height;
    }
    return (height > _maxHeight) ? _maxHeight : height;
}

@end