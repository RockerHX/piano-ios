//
//  HXAlbumsSongCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HXSongModel;


@interface HXAlbumsSongCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *stateIcon;

@property (weak, nonatomic) IBOutlet     UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet     UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet     UILabel *durationLabel;

- (void)updateCellWithSong:(HXSongModel *)song index:(NSInteger)index;

@end
