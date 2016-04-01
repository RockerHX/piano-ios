//
//  HXProfileVideoContainerCell.h
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXVideoModel;
@class HXProfileViewModel;
@class HXProfileVideoContainerCell;


@protocol HXProfileVideoContainerCellDelegate <NSObject>

@required
- (void)videoCell:(HXProfileVideoContainerCell *)cell selectedVideo:(HXVideoModel *)video;

@end


@interface HXProfileVideoContainerCell : UITableViewCell <
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet id  <HXProfileVideoContainerCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)updateCellWithViewModel:(HXProfileViewModel *)viewModel;

@end
