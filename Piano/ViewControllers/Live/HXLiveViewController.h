//
//  HXLiveViewController.h
//  Piano
//
//  Created by miaios on 16/3/18.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "UIViewController+HXClass.h"

@interface HXLiveViewController : UIViewController

@property(nonatomic, strong) NSString *roomType;
@property(nonatomic, strong) NSString *roomTitle;
@property(nonatomic, strong) NSString *roomNumber;
@property(nonatomic, strong) NSString *roomToken;
@property(nonatomic, strong) NSString *createTime;
@property(nonatomic, strong) NSString *endTime;
@property(nonatomic, strong) NSString *userName;
@property(nonatomic, strong) NSString *userID;
@property(nonatomic, strong) NSString *userPic;
@property(nonatomic, strong) NSString *publisherName;
@property(nonatomic, strong) NSString *publisherID;
@property(nonatomic, strong) NSString *publisherPic;
@property(nonatomic, strong) NSString *replayPath;
@property(nonatomic, strong) NSString *coverPath;

- (IBAction)exitButtonPressed;

@end
