//
//  HXDiscoveryContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryContainerViewController.h"
#import "HXCollectionViewLayout.h"
#import "HXDiscoveryLiveCell.h"
#import "HXDiscoveryShowCell.h"
#import "HXDiscoveryNormalCell.h"


@interface HXDiscoveryContainerViewController () <
HXCollectionViewLayoutDelegate
>
@end


@implementation HXDiscoveryContainerViewController

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    HXCollectionViewLayout *layout = (HXCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    layout.itemSpacing = 12.0f;
    layout.itemSpilled = 20.0f;
}

#pragma mark - Public Methods
- (void)displayDiscoveryList {
    [self endLoad];
}

#pragma mark - Private Methods
- (void)endLoad {
    [self.collectionView reloadData];
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    HXCollectionViewLayout *layout = (HXCollectionViewLayout *)self.collectionView.collectionViewLayout;
//    NSLog(@"%@", @(layout.indexPath.row));
    
    if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:model:)]) {
        [_delegate container:self takeAction:HXDiscoveryContainerActionScroll model:_viewModel.discoveryList[layout.indexPath.row]];
    }
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.discoveryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXDiscoveryShowCell class]) forIndexPath:indexPath];
            break;
        }
        case HXCollectionViewLayoutStylePetty: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXDiscoveryNormalCell class]) forIndexPath:indexPath];
            break;
        }
    }
    
    return cell;
}

#pragma mark - Collection View Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            HXDiscoveryShowCell *showCell = (HXDiscoveryShowCell *)cell;
            ;
            break;
        }
        case HXCollectionViewLayoutStylePetty: {
            HXDiscoveryNormalCell *normalCell = (HXDiscoveryNormalCell *)cell;
            [normalCell updateCellWithModel:_viewModel.discoveryList[indexPath.row]];
            break;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            ;
            break;
        }
        case HXCollectionViewLayoutStylePetty: {
            ;
            break;
        }
    }
}

#pragma mark - HXCollectionViewLayoutDelegate Methods
- (HXCollectionViewLayoutStyle)collectionView:(UICollectionView *)collectionView layout:(HXCollectionViewLayout *)layout styleForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _viewModel.discoveryList[indexPath.row].live ? HXCollectionViewLayoutStyleHeavy : HXCollectionViewLayoutStylePetty;
}

//#pragma mark - HXDiscoveryLiveCellDelegate Methods
//- (void)discoveryLiveCellAnchorContainerTaped:(HXDiscoveryLiveCell *)cell {
//    NSInteger row = [self.tableView indexPathForCell:cell].row;
//    if (_delegate && [_delegate respondsToSelector:@selector(container:showAnchorByModel:)]) {
//        [_delegate container:self showAnchorByModel:_viewModel.discoveryList[row]];
//    }
//}
//
//#pragma mark - HXDiscoveryNormalCellDelegate Methods
//- (void)discoveryNormalCellAnchorContainerTaped:(HXDiscoveryNormalCell *)cell {
//    NSInteger row = [self.tableView indexPathForCell:cell].row;
//    if (_delegate && [_delegate respondsToSelector:@selector(container:showAnchorByModel:)]) {
//        [_delegate container:self showAnchorByModel:_viewModel.discoveryList[row]];
//    }
//}

@end
