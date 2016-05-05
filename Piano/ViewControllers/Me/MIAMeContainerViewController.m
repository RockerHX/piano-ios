//
//  MIAMeContainerViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/5.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAMeContainerViewController.h"
#import "MIAMeAttentionPromptCell.h"
#import "MIAMeAttentionContainerCell.h"
#import "MIABaseCellHeadView.h"
#import "NSString+JOExtend.h"
#import "JOBaseSDK.h"

static CGFloat const kMeHeadViewHeight = 360.;
static CGFloat const kMeHeadImageViewWidth = 200.;
static CGFloat const kMeSectionHeadNormalHeight = 55.;

@interface MIAMeContainerViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *maskImageView;

@property (nonatomic, strong) UITableView *meTableView;

@property (nonatomic, strong) UIView *meHeadView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *signatureLabel;

@end

@implementation MIAMeContainerViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)loadView{

    [super loadView];
    
//    [self setTitle:@"个人页面"];
    [self createBackGroundImageView];
    [self createHeadView];
    [self createMeTableView];
    
    JOConvertStringToNormalString(@"test");
}

#pragma mark - Create View

- (void)createBackGroundImageView{

    self.coverImageView = [UIImageView newAutoLayoutView];
    [_coverImageView setBackgroundColor:[UIColor purpleColor]];
    [self.view addSubview:_coverImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_coverImageView superView:self.view];
//    PR-MaskBG
    self.maskImageView = [UIImageView newAutoLayoutView];
    [_maskImageView setBackgroundColor:[UIColor clearColor]];
    [_maskImageView setImage:[UIImage imageNamed:@"PR-MaskBG"]];
    [self.view addSubview:_maskImageView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_maskImageView superView:self.view];
}

- (void)createMeTableView{

    self.meTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_meTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_meTableView setBackgroundColor:[UIColor clearColor]];
    [_meTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_meTableView setSectionFooterHeight:CGFLOAT_MIN];
    [_meTableView setDataSource:self];
    [_meTableView setDelegate:self];
    [self.view addSubview:_meTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_meTableView superView:self.view];
}

- (void)createHeadView{

    self.meHeadView = [[UIView alloc] initWithFrame:CGRectMake(0., 0., self.view.frame.size.width, kMeHeadViewHeight)];
    
    self.headImageView = [UIImageView newAutoLayoutView];
    [_headImageView setBackgroundColor:[UIColor purpleColor]];
    [[_headImageView layer] setCornerRadius:kMeHeadImageViewWidth/2.];
    [[_headImageView layer] setMasksToBounds:YES];
    [_meHeadView addSubview:_headImageView];
    
    self.nickNameLabel = [UILabel newAutoLayoutView];
    [_nickNameLabel setBackgroundColor:[UIColor clearColor]];
    [_nickNameLabel setTextColor:[UIColor whiteColor]];
    [_nickNameLabel setTextAlignment:NSTextAlignmentCenter];
    [_nickNameLabel setFont:[UIFont systemFontOfSize:20.]];
    [_nickNameLabel setText:@"小和尚"];
    [_meHeadView addSubview:_nickNameLabel];
    
    self.signatureLabel = [UILabel newAutoLayoutView];
    [_signatureLabel setBackgroundColor:[UIColor clearColor]];
    [_signatureLabel setTextColor:[UIColor grayColor]];
    [_signatureLabel setText:@"色即是空,空即是色"];
    [_signatureLabel setTextAlignment:NSTextAlignmentCenter];
    [_meHeadView addSubview:_signatureLabel];
    
    [JOAutoLayout autoLayoutWithTopSpaceDistance:50. selfView:_headImageView superView:_meHeadView];
    [JOAutoLayout autoLayoutWithSize:CGSizeMake(kMeHeadImageViewWidth, kMeHeadImageViewWidth) selfView:_headImageView superView:_meHeadView];
    [JOAutoLayout autoLayoutWithCenterXWithView:_meHeadView selfView:_headImageView superView:_meHeadView];
    
    [JOAutoLayout autoLayoutWithTopView:_headImageView distance:15. selfView:_nickNameLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:20. selfView:_nickNameLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:-20. selfView:_nickNameLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithHeight:30. selfView:_nickNameLabel superView:_meHeadView];
    
    [JOAutoLayout autoLayoutWithTopView:_nickNameLabel distance:0. selfView:_signatureLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithHeight:20. selfView:_signatureLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithLeftXView:_nickNameLabel selfView:_signatureLabel superView:_meHeadView];
    [JOAutoLayout autoLayoutWithRightXView:_nickNameLabel selfView:_signatureLabel superView:_meHeadView];
    
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 2.;
    }else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        if (indexPath.section == 0) {
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }else if (indexPath.section == 1){
        
            cell = [[MIAMeAttentionPromptCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [(MIAMeAttentionPromptCell *)cell setCellWidth:View_Width(self.view)];
            [(MIAMeAttentionPromptCell *)cell setMeAttentionPromptData:@[@"",@"",@"",@""]];
        }else if (indexPath.section == 2){
        
//            MIAMeAttentionContainerCell
            cell = [[MIAMeAttentionContainerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            [(MIAMeAttentionContainerCell *)cell setCellWidth:View_Width(self.view)];
            [(MIAMeAttentionContainerCell *)cell setMeAttentionConatinerData:@[@"",@"",@"",@""]];
        }
        else{
        
             cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
       
    }
    [[cell textLabel] setTextColor:[UIColor whiteColor]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:JOConvertRGBToColor(21., 21., 21., 1.)];
    
    if (indexPath.section == 0 ) {
        
        
        if (indexPath.row == 0) {
            NSMutableAttributedString *string = [@"我的M币(充值)" JOAttributedStringwithMarkString:@"(充值)"
                                                                                     markFont:[UIFont systemFontOfSize:16]
                                                                                    markColor:[UIColor grayColor]];
            
            [[cell textLabel] setAttributedText:string];
        }
      
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 50.;
    }else if(indexPath.section == 1){
    
        return 120.;
    }else if (indexPath.section == 2){
    
        return 140.;
    }else{
    
        return 50.;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        //头像部分的高度
        return kMeHeadViewHeight;
    }else{
        
        return kMeSectionHeadNormalHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return _meHeadView;
    }else if(section == 1){
        
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PL-PlayIcon"]
                                                    title:@"关注"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kMeSectionHeadNormalHeight)
                                            cellColorType:BaseCellHeadColorTypeWhiter];
    }else if (section == 2){
    
        return [MIABaseCellHeadView cellHeadViewWithImage:[UIImage imageNamed:@"PL-PlayIcon"]
                                                    title:@"打赏的专辑"
                                                 tipTitle:nil
                                                    frame:CGRectMake(0., 0., View_Width(self.view), kMeSectionHeadNormalHeight)
                                            cellColorType:BaseCellHeadColorTypeWhiter];
    }else{
    
        return nil;
    }
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
