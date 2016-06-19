//
//  HXLiveGiftContainerViewController.h
//  Piano
//
//  Created by miaios on 16/5/23.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXGiftModel;
@protocol HXLiveGiftContainerViewControllerDelegate;


@interface HXLiveGiftContainerViewController : UICollectionViewController

@property (weak, nonatomic) id  <HXLiveGiftContainerViewControllerDelegate>delegate;

@property (nonatomic, strong) NSArray *gifts;

@property (nonatomic, assign, readonly) NSInteger  selectedIndex;
@property (nonatomic, assign, readonly)   CGFloat  contianerHeight;

@end


@protocol HXLiveGiftContainerViewControllerDelegate <NSObject>

@required
- (void)container:(HXLiveGiftContainerViewController *)container selectedGift:(HXGiftModel *)gift;

@end
