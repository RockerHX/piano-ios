//
//  HXMeHeaderCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXProfileModel.h"


typedef NS_ENUM(NSUInteger, HXMeHeaderCellAction) {
    HXMeHeaderCellActionAvatarTaped,
    HXMeHeaderCellActionNickNameTaped,
    HXMeHeaderCellActionSummaryTaped,
};


@class HXMeHeaderCell;


@protocol HXMeHeaderCellDelegate <NSObject>

@required
- (void)headerCell:(HXMeHeaderCell *)cell takeAction:(HXMeHeaderCellAction)action;

@end


@interface HXMeHeaderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet          id  <HXMeHeaderCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet     UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *summaryLabel;

- (void)updateCellWithProfileModel:(HXProfileModel *)model;

@end
