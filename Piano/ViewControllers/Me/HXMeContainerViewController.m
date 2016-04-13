//
//  HXMeContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeContainerViewController.h"
#import "HXMeHeaderCell.h"
#import "HXMeRechargeCell.h"
#import "HXMePurchaseHistoryCell.h"
#import "HXMeMyStationCell.h"
#import "HXMeAttentionPromptCell.h"
#import "HXMeAttentionContainerCell.h"


@interface HXMeContainerViewController () <
HXMeAttentionContainerCellDelegate
>
@end


@implementation HXMeContainerViewController

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
    ;
}

#pragma mark - Public Methods
- (void)refresh {
    [self.tableView reloadData];
}

#pragma mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (_delegate && [_delegate respondsToSelector:@selector(container:scrollOffset:)]) {
        [_delegate container:self scrollOffset:scrollView.contentOffset.y];
    }
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXMeRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXMeRowTypeHeader: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeHeaderCell class]) forIndexPath:indexPath];
            break;
        }
        case HXMeRowTypeRecharge: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeRechargeCell class]) forIndexPath:indexPath];
            break;
        }
        case HXMeRowTypePurchaseHistory: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMePurchaseHistoryCell class]) forIndexPath:indexPath];
            break;
        }
        case HXMeRowTypeMyStation: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeMyStationCell class]) forIndexPath:indexPath];
            break;
        }
        case HXMeRowTypeAttentionPrompt: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeAttentionPromptCell class]) forIndexPath:indexPath];
            break;
        }
        case HXMeRowTypeAttentions: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeAttentionContainerCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXMeRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXMeRowTypeHeader: {
            height = _viewModel.headerHeight;
            break;
        }
        case HXMeRowTypeRecharge:
        case HXMeRowTypePurchaseHistory:
        case HXMeRowTypeMyStation:
        case HXMeRowTypeAttentionPrompt: {
            height = _viewModel.normalHeight;
            break;
        }
        case HXMeRowTypeAttentions: {
            height = _viewModel.attentionHeight;
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXMeRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXMeRowTypeHeader: {
            [(HXMeHeaderCell *)cell updateCellWithProfileModel:_viewModel.model];
            break;
        }
        case HXMeRowTypeAttentionPrompt: {
            [(HXMeAttentionPromptCell *)cell updateCellWithCount:_viewModel.model.attentions.count];
            break;
        }
        case HXMeRowTypeAttentions: {
            [(HXMeAttentionContainerCell *)cell updateCellWithAttentions:_viewModel.model.attentions];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HXMeRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXMeRowTypeRecharge: {
            ;
            break;
        }
        case HXMeRowTypePurchaseHistory: {
            ;
            break;
        }
        case HXMeRowTypeMyStation: {
            ;
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - HXMeAttentionContainerCellDelegate Methods
- (void)attentionCell:(HXMeAttentionContainerCell *)cell selectedAttention:(HXAttentionModel *)attention {
    if (_delegate && [_delegate respondsToSelector:@selector(container:hanleAttentionAnchor:)]) {
        [_delegate container:self hanleAttentionAnchor:attention];
    }
}

@end
