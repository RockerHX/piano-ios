//
//  HXAlbumsCommentViewController.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"


@class HXAlbumsCommentViewController;


@protocol HXAlbumsCommentViewControllerDelegate <NSObject>

@required
- (void)commentViewControllerCompleted:(HXAlbumsCommentViewController *)viewController;

@end


@interface HXAlbumsCommentViewController : UIViewController

@property (weak, nonatomic) IBOutlet          id  <HXAlbumsCommentViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet      UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet    UIButton *sendButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (nonatomic, strong) NSString *albumID;

- (IBAction)sendButtonPressed;

@end
