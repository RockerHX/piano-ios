//
//  HXPreviewLiveEidtView.h
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXPreviewLiveEidtView : UIView

@property (weak, nonatomic) IBOutlet      UIView *container;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet     UILabel *locationLabel;

- (IBAction)cameraButtonPressed;

@end
