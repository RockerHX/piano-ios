//
//  HXPreviewLiveEidtView.m
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXPreviewLiveEidtView.h"
#import "HXXib.h"


@implementation HXPreviewLiveEidtView

HXXibImplementation

#pragma mark - Load Methods
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    _container.backgroundColor = [UIColor clearColor];
    
    [_textField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

#pragma mark - Event Response
- (IBAction)addAlbumButtonPressed {
    if (_delegate && [_delegate respondsToSelector:@selector(editView:takeAction:)]) {
        [_delegate editView:self takeAction:HXPreviewLiveEidtViewActionAddAlbum];
    }
}

- (IBAction)clearButtonPressed {
    _addAlbumButton.hidden = NO;
    _albumNameLabel.hidden = YES;
    _albumContainer.hidden = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(editView:takeAction:)]) {
        [_delegate editView:self takeAction:HXPreviewLiveEidtViewActionClear];
    }
}

#pragma mark - UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
