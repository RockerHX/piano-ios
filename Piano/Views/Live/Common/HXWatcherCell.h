//
//  HXWatcherCell.h
//  Piano
//
//  Created by miaios on 16/3/31.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXWatcherModel.h"


@interface HXWatcherCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;

- (void)updateWithWatcher:(HXWatcherModel *)watcher;

@end
