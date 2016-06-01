//
//  HXMeRewardAlbumContainerCell.h
//  Piano
//
//  Created by miaios on 16/6/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXAlbumModel;
@protocol HXMeRewardAlbumContainerCellDelegate;


@interface HXMeRewardAlbumContainerCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet id  <HXMeRewardAlbumContainerCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)updateCellWithAlbums:(NSArray *)albums;

@end



@protocol HXMeRewardAlbumContainerCellDelegate <NSObject>

@required
- (void)attentionCell:(HXMeRewardAlbumContainerCell *)cell selectedAlbum:(HXAlbumModel *)album;

@end