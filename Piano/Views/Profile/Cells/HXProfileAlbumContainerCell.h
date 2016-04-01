//
//  HXProfileAlbumContainerCell.h
//  Piano
//
//  Created by miaios on 16/4/1.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXAlbumModel;
@class HXProfileViewModel;
@class HXProfileAlbumContainerCell;


@protocol HXProfileAlbumContainerCellDelegate <NSObject>

@required
- (void)albumCell:(HXProfileAlbumContainerCell *)cell selectedAlbum:(HXAlbumModel *)album;

@end


@interface HXProfileAlbumContainerCell : UITableViewCell <
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout
>

@property (weak, nonatomic) IBOutlet id  <HXProfileAlbumContainerCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (void)updateCellWithViewModel:(HXProfileViewModel *)viewModel;

@end
