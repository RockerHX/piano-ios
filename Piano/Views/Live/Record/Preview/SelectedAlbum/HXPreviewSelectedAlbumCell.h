//
//  HXPreviewSelectedAlbumCell.h
//  Piano
//
//  Created by miaios on 16/5/17.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXAlbumModel.h"


@interface HXPreviewSelectedAlbumCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *coverView;
@property (weak, nonatomic) IBOutlet      UIView *selectedMaskView;
@property (weak, nonatomic) IBOutlet     UILabel *titleLabel;

- (void)updateWithAlbum:(HXAlbumModel *)album;

@end
