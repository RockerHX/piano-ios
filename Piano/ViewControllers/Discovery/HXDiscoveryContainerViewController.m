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
#import "ReactiveCocoa.h"


@interface HXDiscoveryContainerViewController () <
HXCollectionViewLayoutDelegate,
HXDiscoveryLiveCellDelegate
>
@end


@implementation HXDiscoveryContainerViewController {
    HXDiscoveryPreviewCell *_previewCell;
}

#pragma mark - View Controller Life Cycle
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self stopPreviewVideo];
}

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

- (void)stopPreviewVideo {
    [_previewCell stopPlay];
}

- (void)reload {
    [self.collectionView reloadData];
}

#pragma mark - Private Methods
- (void)endLoad {
    [self.collectionView reloadData];
    [self performSelector:@selector(previewFirstCell) withObject:nil afterDelay:1.0f];
}

- (void)previewFirstCell {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[HXDiscoveryPreviewCell class]] && ![_previewCell isEqual:cell]) {
        [self previewAtIndexPath:indexPath];
    }
}

- (void)previewAtIndexPath:(NSIndexPath *)indexPath {
    [self stopPreviewVideo];
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[HXDiscoveryPreviewCell class]]) {
        HXDiscoveryPreviewCell *previewCell = (HXDiscoveryPreviewCell *)cell;
        [previewCell playWithURL:_viewModel.discoveryList[indexPath.row].videoUrl];
        _previewCell = previewCell;
    }
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    HXCollectionViewLayout *layout = (HXCollectionViewLayout *)self.collectionView.collectionViewLayout;
//    NSLog(@"%@", @(layout.indexPath.row));
    
    NSIndexPath *indexPath = layout.indexPath;
    [self previewAtIndexPath:indexPath];
    
    NSInteger index = indexPath.row;
    if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:model:)]) {
        [_delegate container:self takeAction:HXDiscoveryContainerActionScroll model:_viewModel.discoveryList[index]];
    }

#warning andy
	if (_viewModel.discoveryList[indexPath.row].type == HXDiscoveryModelTypeProfile) {
		if (scrollView.contentOffset.x == 20.0f) {
			if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:model:)]) {
				[_delegate container:self takeAction:HXDiscoveryContainerActionRefresh model:_viewModel.discoveryList[index]];
			}
		}
	} else {
		if (scrollView.contentOffset.x == 0.0f) {
			if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:model:)]) {
				[_delegate container:self takeAction:HXDiscoveryContainerActionRefresh model:_viewModel.discoveryList[index]];
			}
		}
	}
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _viewModel.discoveryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    HXDiscoveryModel *model = _viewModel.discoveryList[indexPath.row];
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            if (model.type == HXDiscoveryModelTypeAnchor) {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXDiscoveryLiveCell class]) forIndexPath:indexPath];
            } else {
                cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXDiscoveryShowCell class]) forIndexPath:indexPath];
            }
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
    HXDiscoveryModel *model = _viewModel.discoveryList[indexPath.row];
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            if (model.type == HXDiscoveryModelTypeAnchor) {
                HXDiscoveryLiveCell *liveCell = (HXDiscoveryLiveCell *)cell;
                [liveCell updateCellWithModel:model];
            } else {
                HXDiscoveryShowCell *showCell = (HXDiscoveryShowCell *)cell;
                [showCell updateCellWithModel:model];
            }
            break;
        }
        case HXCollectionViewLayoutStylePetty: {
            HXDiscoveryNormalCell *normalCell = (HXDiscoveryNormalCell *)cell;
            [normalCell updateCellWithModel:model];
            break;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HXDiscoveryContainerAction action;
    HXDiscoveryModel *model = _viewModel.discoveryList[indexPath.row];
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            if (model.type == HXDiscoveryModelTypeAnchor) {
                return;
            } else {
                action = HXDiscoveryContainerActionShowLive;
            }
            break;
        }
        case HXCollectionViewLayoutStylePetty: {
            action = HXDiscoveryContainerActionShowStation;
            break;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:model:)]) {
        [_delegate container:self takeAction:action model:model];
    }
}

#pragma mark - HXCollectionViewLayoutDelegate Methods
- (HXCollectionViewLayoutStyle)collectionView:(UICollectionView *)collectionView layout:(HXCollectionViewLayout *)layout styleForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (_viewModel.discoveryList[indexPath.row].type == HXDiscoveryModelTypeProfile) ? HXCollectionViewLayoutStylePetty : HXCollectionViewLayoutStyleHeavy;
}

#pragma mark - HXDiscoveryLiveCellDelegate Methods
- (void)liveCell:(HXDiscoveryLiveCell *)cell takeAction:(HXDiscoveryLiveCellAction)action {
    HXDiscoveryContainerAction conatinerAction;
    switch (action) {
        case HXDiscoveryLiveCellActionStartLive: {
            conatinerAction = HXDiscoveryContainerActionStartLive;
            break;
        }
        case HXDiscoveryLiveCellActionChangeCover: {
            conatinerAction = HXDiscoveryContainerActionChangeCover;
            break;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:model:)]) {
        [_delegate container:self takeAction:conatinerAction model:nil];
    }
}

@end
