//
//  HXCountDownViewController.h
//  Piano
//
//  Created by miaios on 16/4/7.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HXCountDownViewControllerDelegate <NSObject>

@required
- (void)countDownFinished;

@end


@interface HXCountDownViewController : UIViewController

@property (weak, nonatomic) IBOutlet      id  <HXCountDownViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)startCountDown;

@end
