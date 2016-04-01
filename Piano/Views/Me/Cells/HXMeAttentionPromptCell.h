//
//  HXMeAttentionPromptCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HXMeAttentionPromptCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)updateCellWithCount:(NSInteger)count;

@end
