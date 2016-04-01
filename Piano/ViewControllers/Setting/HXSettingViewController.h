//
//  HXSettingViewController.h
//  mia
//
//  Created by miaios on 15/11/20.
//  Copyright © 2015年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXSettingViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet     UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet    UISwitch *networkingSwitch;
@property (weak, nonatomic) IBOutlet     UILabel *cacheLabel;
@property (weak, nonatomic) IBOutlet     UILabel *versionLabel;

- (IBAction)playWith3GSwitchAction:(UISwitch *)sender;

@end
