//
//  HXLiveBarrageContainerViewController.h
//  Piano
//
//  Created by miaios on 16/3/24.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXBarrageModel;
@class HXLiveBarrageContainerViewController;


@protocol HXLiveBarrageContainerViewControllerDelegate <NSObject>

@required
- (void)barrageContainer:(HXLiveBarrageContainerViewController *)container shouldShowBarrage:(HXBarrageModel *)barrage;

@end


@interface HXLiveBarrageContainerViewController : UITableViewController

@property (weak, nonatomic) IBOutlet id  <HXLiveBarrageContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *barrages;

@end
