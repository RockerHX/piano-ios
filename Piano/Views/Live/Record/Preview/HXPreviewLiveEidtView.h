//
//  HXPreviewLiveEidtView.h
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXPreviewLiveEidtViewAction) {
    HXPreviewLiveEidtViewActionEdit,
    HXPreviewLiveEidtViewActionAddAlbum,
};


@class HXPreviewLiveEidtView;


@protocol HXPreviewLiveEidtViewDelegate <NSObject>

@required
- (void)editView:(HXPreviewLiveEidtView *)editView takeAction:(HXPreviewLiveEidtViewAction)action;

@end


@interface HXPreviewLiveEidtView : UIView <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet          id  <HXPreviewLiveEidtViewDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *container;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet    UIButton *addAlbumButton;
@property (weak, nonatomic) IBOutlet UIImageView *albumCoverView;

- (IBAction)addAlbumButtonPressed;

@end
