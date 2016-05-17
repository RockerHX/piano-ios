//
//  HXPreviewSelectedAlbumCell.h
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAlbumModel.h"


@interface HXPreviewSelectedAlbumCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet     UILabel *summaryLabel;

- (void)displayWithAlbum:(HXAlbumModel *)album;

@end
