//
//  HXHostProfileContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXHostProfileContainerViewController.h"
#import "HXMeRechargeCell.h"
#import "HXMePurchaseHistoryCell.h"
#import "HXMeAttentionPromptCell.h"
#import "HXMeAttentionContainerCell.h"
#import "HXMeRewardAlbumPromptCell.h"
#import "HXMeRewardAlbumContainerCell.h"
#import "UIImageView+WebCache.h"
#import "HXSettingViewController.h"
#import "MIASettingViewController.h"


@interface HXHostProfileContainerViewController () <
HXMeAttentionContainerCellDelegate,
HXMeRewardAlbumContainerCellDelegate
>
@end


@implementation HXHostProfileContainerViewController

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

#pragma mark - Event Response
- (IBAction)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)settingButtonPressed {
    [self.navigationController pushViewController:[MIASettingViewController new] animated:YES];
}

#pragma mark - Public Methods
- (void)refresh {
    [self updateHeaderWithProfileModel:_viewModel.model];
    [self.tableView reloadData];
}

#pragma mark - Private Methods
- (void)updateHeaderWithProfileModel:(HXProfileModel *)model {
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:model.avatarUrl]];
    _nickNameLabel.text = model.nickName;
    _signatureLabel.text = model.summary;
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    HXHostProfileRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXHostProfileRowTypeRecharge: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeRechargeCell class]) forIndexPath:indexPath];
            break;
        }
        case HXHostProfileRowTypePurchaseHistory: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMePurchaseHistoryCell class]) forIndexPath:indexPath];
            break;
        }
        case HXHostProfileRowTypeAttentionPrompt: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeAttentionPromptCell class]) forIndexPath:indexPath];
            break;
        }
        case HXHostProfileRowTypeAttentions: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeAttentionContainerCell class]) forIndexPath:indexPath];
            break;
        }
        case HXHostProfileRowTypeRewardAlbumPrompt: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeRewardAlbumPromptCell class]) forIndexPath:indexPath];
            break;
        }
        case HXHostProfileRowTypeRewardAlbums: {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HXMeRewardAlbumContainerCell class]) forIndexPath:indexPath];
            break;
        }
    }
    return cell;
}

#pragma mark - Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0f;
    HXHostProfileRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXHostProfileRowTypeRecharge:
        case HXHostProfileRowTypePurchaseHistory:
        case HXHostProfileRowTypeAttentionPrompt:
        case HXHostProfileRowTypeRewardAlbumPrompt: {
            height = _viewModel.normalHeight;
            break;
        }
        case HXHostProfileRowTypeAttentions: {
            height = _viewModel.attentionHeight;
            break;
        }
        case HXHostProfileRowTypeRewardAlbums: {
            height = _viewModel.rewardAlbumHeight;
            break;
        }
    }
    return height;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    HXHostProfileRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXHostProfileRowTypeAttentionPrompt: {
            [(HXMeAttentionPromptCell *)cell updateCellWithCount:_viewModel.model.attentions.count];
            break;
        }
        case HXHostProfileRowTypeAttentions: {
            [(HXMeAttentionContainerCell *)cell updateCellWithViewModel:_viewModel];
            break;
        }
        case HXHostProfileRowTypeRewardAlbums: {
            [(HXMeRewardAlbumContainerCell *)cell updateCellWithViewModel:_viewModel];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HXHostProfileRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
        case HXHostProfileRowTypeRecharge: {
            if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:)]) {
                [_delegate container:self takeAction:HXHostProfileContainerActionRecharge];
            }
            break;
        }
        case HXHostProfileRowTypePurchaseHistory: {
            if (_delegate && [_delegate respondsToSelector:@selector(container:takeAction:)]) {
                [_delegate container:self takeAction:HXHostProfileContainerActionPurchaseHistory];
            }
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - HXMeAttentionContainerCellDelegate Methods
- (void)attentionCell:(HXMeAttentionContainerCell *)cell selectedAttention:(HXAttentionModel *)attention {
    if (_delegate && [_delegate respondsToSelector:@selector(container:showAttentionAnchor:)]) {
        [_delegate container:self showAttentionAnchor:attention];
    }
}

#pragma mark - HXMeRewardAlbumContainerCellDelegate Methods
- (void)rewardAlbumCell:(HXMeRewardAlbumContainerCell *)cell selectedAlbum:(HXAlbumModel *)album {
    if (_delegate && [_delegate respondsToSelector:@selector(container:showRewardAlbum:)]) {
        [_delegate container:self showRewardAlbum:album];
    }
}

@end
