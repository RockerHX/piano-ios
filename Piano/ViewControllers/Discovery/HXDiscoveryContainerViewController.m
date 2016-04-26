//
//  HXDiscoveryContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/16.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXDiscoveryContainerViewController.h"
#import "HXDiscoveryViewModel.h"
#import "HXCollectionViewLayout.h"
#import "HXDiscoveryLiveCell.h"
#import "HXDiscoveryNormalCell.h"


@interface HXDiscoveryContainerViewController () <
HXCollectionViewLayoutDelegate
>
@end


@implementation HXDiscoveryContainerViewController {
    NSInteger _itemCount;
    HXDiscoveryViewModel *_viewModel;
}

#pragma mark - View Controller Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadConfigure];
    [self viewConfigure];
}

#pragma mark - Configure Methods
- (void)loadConfigure {
    _itemCount = 20;
    _viewModel = [[HXDiscoveryViewModel alloc] init];
}

- (void)viewConfigure {
    HXCollectionViewLayout *layout = (HXCollectionViewLayout *)self.collectionView.collectionViewLayout;
    layout.delegate = self;
    layout.itemSpacing = 12.0f;
    layout.itemSpilled = 20.0f;
}

#pragma mark - Public Methods
- (void)startFetchDiscoveryList {
    ;
}

- (void)fetchDiscoveryList {
    @weakify(self)
    RACSignal *requestSiganl = [_viewModel.fetchCommand execute:nil];
    [requestSiganl subscribeError:^(NSError *error) {
        @strongify(self)
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
//            [self showBannerWithPrompt:error.domain];
        }
        [self endLoad];
    } completed:^{
        @strongify(self)
        [self endLoad];
    }];
}

#pragma mark - Private Methods
- (void)endLoad {
    ;
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    HXCollectionViewLayout *layout = (HXCollectionViewLayout *)self.collectionView.collectionViewLayout;
    NSLog(@"%@", @(layout.indexPath.row));
}

#pragma mark - Collection View Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    
    HXCollectionViewLayoutStyle style = [self collectionView:collectionView layout:(HXCollectionViewLayout *)self.collectionView.collectionViewLayout styleForItemAtIndexPath:indexPath];
    switch (style) {
        case HXCollectionViewLayoutStyleHeavy: {
            cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HXDiscoveryLiveCell class]) forIndexPath:indexPath];
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ;
}

#pragma mark - HXCollectionViewLayoutDelegate Methods
- (HXCollectionViewLayoutStyle)collectionView:(UICollectionView *)collectionView layout:(HXCollectionViewLayout *)layout styleForItemAtIndexPath:(NSIndexPath *)indexPath {
    return (indexPath.row < 5) ? HXCollectionViewLayoutStyleHeavy : HXCollectionViewLayoutStylePetty;
}

#pragma mark - HXDiscoveryLiveCellDelegate Methods
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
