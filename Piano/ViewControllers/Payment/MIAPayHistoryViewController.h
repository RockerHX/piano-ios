//
//  MIAPayHistoryViewController.h
//  Piano
//
//  Created by 刘维 on 16/5/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HistoryType){

    HistoryType_Guest, //客人
    HistoryType_Host, //主播
};

@interface MIAPayHistoryViewController : UIViewController

@property (nonatomic, assign) HistoryType historyType;

@end
