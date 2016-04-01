//
//  HXMeAttentionContainerCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXAttentionModel;
@class HXMeAttentionContainerCell;


@protocol HXMeAttentionContainerCellDelegate <NSObject>

@required
- (void)attentionCell:(HXMeAttentionContainerCell *)cell selectedAttention:(HXAttentionModel *)attention;

@end


@interface HXMeAttentionContainerCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet id  <HXMeAttentionContainerCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)updateCellWithAttentions:(NSArray *)attentions;

@end
