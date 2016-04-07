//
//  HXAlbumsControlCell.h
//  Piano
//
//  Created by miaios on 16/3/28.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, HXAlbumsControlCellAction) {
    HXAlbumsControlCellActionPlay,
    HXAlbumsControlCellActionPause,
    HXAlbumsControlCellActionPrevious,
    HXAlbumsControlCellActionNext,
};


@class HXAlbumModel;
@class HXAlbumsControlCell;


@protocol HXAlbumsControlCellDelegate <NSObject>

@required
- (void)controlCell:(HXAlbumsControlCell *)cell takeAction:(HXAlbumsControlCellAction)action;
- (void)controlCell:(HXAlbumsControlCell *)cell seekToPosition:(float)postion;

@end


@interface HXAlbumsControlCell : UITableViewCell

@property (weak, nonatomic) IBOutlet          id  <HXAlbumsControlCellDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *cover;
@property (weak, nonatomic) IBOutlet    UIButton *playButton;
@property (weak, nonatomic) IBOutlet     UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet    UISlider *slider;
@property (weak, nonatomic) IBOutlet     UILabel *durationTimeLabel;

- (IBAction)playButtonPressed:(UIButton *)button;
- (IBAction)previousButtonPressed;
- (IBAction)nextButtonPressed;
- (IBAction)valueChange:(UISlider *)slider;

- (void)updateCellWithAlbum:(HXAlbumModel *)model;

@end
