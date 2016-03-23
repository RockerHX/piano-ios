//
//  HXRegisterViewController.h
//  Mia
//
//  Created by miaios on 16/1/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTTAttributedLabel;

@interface HXRegisterViewController : UIViewController

@property (weak, nonatomic) IBOutlet            UILabel *firstPromptLabel;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *secondPromptLabel;

@end
