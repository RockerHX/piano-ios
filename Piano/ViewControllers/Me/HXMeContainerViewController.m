//
//  HXMeContainerViewController.m
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "HXMeContainerViewController.h"
#import "HXMeRechargeCell.h"
#import "HXMePurchaseHistoryCell.h"
#import "HXMeMyStationCell.h"
#import "HXMeAttentionPromptCell.h"
#import "HXMeAttentionContainerCell.h"
#import "UIImageView+WebCache.h"

#import "MIAMeContainerViewController.h"


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
    
//    MIAAttentionPromptView *attentionPromptView = [MIAAttentionPromptView newAutoLayoutView];
//    [attentionPromptView setShowData:nil];
//    [attentionPromptView setAttentionPromptViewWidth:80.];
//    [self.view addSubview:attentionPromptView];
//    
//    [JOAutoLayout autoLayoutWithLeftSpaceDistance:50. selfView:attentionPromptView superView:self.view];
//    [JOAutoLayout autoLayoutWithTopSpaceDistance:200. selfView:attentionPromptView superView:self.view];
//    [JOAutoLayout autoLayoutWithWidth:80. selfView:attentionPromptView superView:self.view];
//    [JOAutoLayout autoLayoutWithHeight:110. selfView:attentionPromptView superView:self.view];
//    
//    MIAAttentionContainerView *attentionContainerView = [MIAAttentionContainerView newAutoLayoutView];
//    [attentionContainerView setShowData:nil];
//    [self.view addSubview:attentionContainerView];
//    
//    [JOAutoLayout autoLayoutWithTopView:attentionPromptView distance:20. selfView:attentionContainerView superView:self.view];
//    [JOAutoLayout autoLayoutWithLeftXView:attentionPromptView selfView:attentionContainerView superView:self.view];
//    [JOAutoLayout autoLayoutWithWidth:100. selfView:attentionContainerView superView:self.view];
//    [JOAutoLayout autoLayoutWithHeight:130. selfView:attentionContainerView superView:self.view];

}

#pragma mark - Configure Methods
- (void)loadConfigure {
    ;
}

- (void)viewConfigure {
    ;
}

#pragma mark - Event Response
- (IBAction)settingButtonPressed {
    
    MIAMeContainerViewController *meContainerViewController = [MIAMeContainerViewController new];
    [self.navigationController pushViewController:meContainerViewController animated:YES];
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
    HXMeRowType rowType = [_viewModel.rowTypes[indexPath.row] integerValue];
    switch (rowType) {
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
