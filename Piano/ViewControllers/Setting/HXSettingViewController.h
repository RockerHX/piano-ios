//
//  HXSettingViewController.h
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXSettingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIImageView *accountAvAtar;

@property (weak, nonatomic) IBOutlet UIPickerView *liveQualityPicker;

@property (weak, nonatomic) IBOutlet  UILabel *resolutionLabel;
@property (weak, nonatomic) IBOutlet  UILabel *fpsLabel;
@property (weak, nonatomic) IBOutlet  UILabel *bitrateLabel;
@property (weak, nonatomic) IBOutlet UISlider *resolutionSlider;
@property (weak, nonatomic) IBOutlet UISlider *fpsSlider;
@property (weak, nonatomic) IBOutlet UISlider *bitrateSlider;

- (IBAction)resolutionSliderChanged:(UISlider *)sender;
- (IBAction)fpsSliderChanged:(UISlider *)sender;
- (IBAction)bitrateSliderChanged:(UISlider *)sender;

@end
