//
//  MIASettingContentViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/26.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIASettingContentViewController.h"
#import "UIViewController+HXClass.h"
#import "HXTextView.h"
#import "HXAlertBanner.h"
#import "MIANavBarView.h"
#import "JOBaseSDK.h"
#import "MIAFontManage.h"

static CGFloat const kContentNavBarHeight = 50.;//NavBar的高度

@interface MIASettingContentViewController()<UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>{
    
    
}

@property (nonatomic, assign) SettingContentType contentType;
@property (nonatomic, assign) GenderType gender;
@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) MIANavBarView *navBarView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *contentTextField;
@property (nonatomic, strong) HXTextView *contentTextView;
@property (nonatomic, strong) UITableView *contentTableView;

@property (nonatomic, copy) NSArray *contentTableDataArray;
@property (nonatomic, strong) MIASettingContentViewModel *contentViewModel;

@property (nonatomic, copy) SettingContentSaveBlock settingContentSaveBlock;

@end

@implementation MIASettingContentViewController

- (instancetype)initWithContentType:(SettingContentType)type{

    self = [super init];
    if (self) {
        
        self.contentType = type;
        self.gender = GenderMale;
    }
    return self;
}

- (void)setGenderType:(GenderType)type{

    if (type == GenderUnknow) {
        self.gender = GenderMale;
    }else{
        self.gender = type;
    }
}

- (void)setSettingContent:(NSString *)content{

    self.content = nil;
    self.content = content;
}

- (void)loadView{
 
    [super loadView];
    [self.view setBackgroundColor:JORGBSameCreate(240.)];
    
    self.contentTableDataArray = nil;
    self.contentTableDataArray = @[@"男",@"女"];
    
    [self createNavBarView];
    [self createContentView];
    
    [self loadViewModel];
}

- (void)createNavBarView{

    self.navBarView = [MIANavBarView newAutoLayoutView];
    [_navBarView setBackgroundColor:[UIColor whiteColor]];
    [[_navBarView navBarTitleLabel] setTextColor:[UIColor blackColor]];
    [_navBarView setLeftButtonImageName:@"C-BackIcon-Gray"];
    [_navBarView showBottomLineView];
    
    @weakify(self);
    [_navBarView navBarLeftClickHanlder:^{
    @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    } rightClickHandler:^{
    @strongify(self);
        
        if (self.contentType ==  SettingContentType_Nick) {
            //昵称
            [self executeChangeNickNameCommand];
        }else if (self.contentType == SettingContentType_Summary){
            //简介
            [self executeChangeSummayCommand];
        }else if (self.contentType == SettingContentType_Gender){
            //性别
            [self executeChangeGenderCommand];
        }else if (self.contentType == SettingContentType_Feedback){
            //意见反馈
            [self executeFeedbackCommand];
        }
    }];
    [self.view addSubview:_navBarView];
    
    [JOAutoLayout autoLayoutWithLeftSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithRightSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_navBarView superView:self.view];
    [JOAutoLayout autoLayoutWithHeight:kContentNavBarHeight selfView:_navBarView superView:self.view];
}

- (void)createContentView{

    self.contentView = [UIView newAutoLayoutView];
    
    if (_contentType == SettingContentType_Nick) {
        
        //初始化TextField
        [_navBarView setTitle:@"昵称"];
        [_navBarView setRightButtonTitle:@"保存" titleColor:[UIColor blackColor]];
        
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [[_contentView layer] setBorderColor:JORGBSameCreate(220.).CGColor];
        [[_contentView layer] setBorderWidth:1.];
        [self.view addSubview:_contentView];
        
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:-1. selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:1. selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentNavBarHeight + kSettingContentTopSpaceDistance selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithHeight:kSettingContentTextFieldHeight selfView:_contentView superView:self.view];
        
        self.contentTextField = [UITextField newAutoLayoutView];
        [_contentTextField setTextColor:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->color];
        [_contentTextField setFont:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->font];
        [_contentTextField setBackgroundColor:[UIColor clearColor]];
        [_contentTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_contentTextField becomeFirstResponder];
        [_contentTextField setText:_content];
        [_contentView addSubview:_contentTextField];
        
        [JOAutoLayout autoLayoutWithLeftXView:_contentView distance:20. selfView:_contentTextField superView:_contentView];
        [JOAutoLayout autoLayoutWithRightXView:_contentView distance:-20. selfView:_contentTextField superView:_contentView];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:_contentTextField superView:_contentView];
        [JOAutoLayout autoLayoutWithBottomSpaceDistance:0. selfView:_contentTextField superView:_contentView];
        
    }else if(_contentType == SettingContentType_Summary ){
        //简介
        [_navBarView setTitle:@"个人签名"];
        [_navBarView setRightButtonTitle:@"保存" titleColor:[UIColor blackColor]];
        
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_contentView];
        
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:-1. selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:1. selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentNavBarHeight + kSettingContentTopSpaceDistance selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithHeight:kSettingContentTextViewHeight selfView:_contentView superView:self.view];
        
        self.contentTextView = [HXTextView newAutoLayoutView];
        [_contentTextView setTextColor:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->color];
        [_contentTextView setFont:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->font];
        [[_contentTextView layer] setBorderWidth:1.];
        [[_contentTextView layer] setBorderColor:JORGBSameCreate(220.).CGColor];
        [[_contentTextView layer] setMasksToBounds:YES];
        [[_contentTextView layer] setCornerRadius:4.];
        [_contentTextView setBackgroundColor:[UIColor whiteColor]];
        [_contentTextView setText:_content];
        [_contentTextView becomeFirstResponder];
        [_contentView addSubview:_contentTextView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 10., 0., -10.) selfView:_contentTextView superView:_contentView];
        
    }else if (_contentType == SettingContentType_Feedback){
        //意见
        [_navBarView setTitle:@"意见反馈"];
        [_navBarView setRightButtonTitle:@"发送" titleColor:[UIColor blackColor]];
        
        [_contentView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_contentView];
        
        UILabel *feedBackLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Feedback_Tip]];
        [feedBackLabel setText:@"问题描述:"];
        [_contentView addSubview:feedBackLabel];
        
        CGFloat feedbackLaelHeight = [feedBackLabel sizeThatFits:JOMAXSize].height+4.;
        
        [JOAutoLayout autoLayoutWithTopSpaceDistance:0. selfView:feedBackLabel superView:_contentView];
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:10. selfView:feedBackLabel superView:_contentView];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:-10. selfView:feedBackLabel superView:_contentView];
        [JOAutoLayout autoLayoutWithHeight:feedbackLaelHeight selfView:feedBackLabel superView:_contentView];
        
        self.contentTextView = [HXTextView newAutoLayoutView];
        [_contentTextView setTextColor:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->color];
        [_contentTextView setFont:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->font];
        [[_contentTextView layer] setBorderWidth:1.];
        [[_contentTextView layer] setBorderColor:JORGBSameCreate(220.).CGColor];
        [[_contentTextView layer] setMasksToBounds:YES];
        [[_contentTextView layer] setCornerRadius:4.];
        [_contentTextView setBackgroundColor:[UIColor whiteColor]];
        [_contentTextView setPlaceholderText:@"欢迎您提出宝贵的意见或建议,我们将为你不断改进"];
        [_contentTextView becomeFirstResponder];
        [_contentView addSubview:_contentTextView];
        
        [JOAutoLayout autoLayoutWithTopView:feedBackLabel distance:0. selfView:_contentTextView superView:_contentView];
        [JOAutoLayout autoLayoutWithLeftXView:feedBackLabel selfView:_contentTextView superView:_contentView];
        [JOAutoLayout autoLayoutWithRightXView:feedBackLabel selfView:_contentTextView superView:_contentView];
        [JOAutoLayout autoLayoutWithHeight:kSettingContentTextViewHeight selfView:_contentTextView superView:_contentView];
        
        UILabel *contactLabel = [JOUIManage createLabelWithJOFont:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Feedback_Tip]];
        [contactLabel setText:@"联系方式:"];
        [_contentView addSubview:contactLabel];
        
        CGFloat contactLabelHeight = [contactLabel sizeThatFits:JOMAXSize].height+4.;
        
        [JOAutoLayout autoLayoutWithTopView:_contentTextView distance:10. selfView:contactLabel superView:_contentView];
        [JOAutoLayout autoLayoutWithLeftXView:_contentTextView selfView:contactLabel superView:_contentView];
        [JOAutoLayout autoLayoutWithRightXView:_contentTextView selfView:contactLabel superView:_contentView];
        [JOAutoLayout autoLayoutWithHeight:contactLabelHeight selfView:contactLabel superView:_contentView];
        
        self.contentTextField = [UITextField newAutoLayoutView];
        [_contentTextField setTextColor:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->color];
        [_contentTextField setFont:[MIAFontManage getFontWithType:MIAFontType_SettingContent_Content]->font];
        [_contentTextField setBackgroundColor:[UIColor whiteColor]];
        [_contentTextField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_contentTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [_contentTextField setKeyboardType:UIKeyboardTypeNumberPad];
        [_contentTextField setPlaceholder:@"QQ或手机号码(可选)"];
        [_contentView addSubview:_contentTextField];
        
        [JOAutoLayout autoLayoutWithLeftXView:contactLabel selfView:_contentTextField superView:_contentView];
        [JOAutoLayout autoLayoutWithRightXView:contactLabel selfView:_contentTextField superView:_contentView];
        [JOAutoLayout autoLayoutWithTopView:contactLabel distance:0. selfView:_contentTextField superView:_contentView];
        [JOAutoLayout autoLayoutWithHeight:kSettingContentTextFieldHeight selfView:_contentTextField superView:_contentView];
        
        [JOAutoLayout autoLayoutWithLeftSpaceDistance:-1. selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithRightSpaceDistance:1. selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithTopSpaceDistance:kContentNavBarHeight + kSettingContentTopSpaceDistance selfView:_contentView superView:self.view];
        [JOAutoLayout autoLayoutWithHeight:kSettingContentTextViewHeight + feedbackLaelHeight + kSettingContentTextFieldHeight + contactLabelHeight+10  selfView:_contentView superView:self.view];
        
    }else if (_contentType == SettingContentType_Gender){
        //性别
        [_navBarView setTitle:@"性别"];
        [_navBarView setRightButtonTitle:@"保存" titleColor:[UIColor blackColor]];
        
        self.contentTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_contentTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_contentTableView setDelegate:self];
        [_contentTableView setDataSource:self];
        [_contentTableView setSectionFooterHeight:CGFLOAT_MIN];
        [_contentTableView setSectionHeaderHeight:kSettingContentTopSpaceDistance];
        [self.view addSubview:_contentTableView];
        
        [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(kContentNavBarHeight, 0., 0., 0.) selfView:_contentTableView superView:self.view];
    }
}

#pragma mark - pop action

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - view model

- (void)loadViewModel{

    self.contentViewModel = [MIASettingContentViewModel new];
}

#pragma mark - signer

- (void)executeChangeNickNameCommand{

    NSString *text = _contentTextField.text;
    
    if ([JOTrimString(text) length] ) {
        
        [_contentTextField resignFirstResponder];
        
        [self showHUD];
        RACSignal *signal = [_contentViewModel changeNickWithName:text];
        @weakify(self);
        [signal subscribeError:^(NSError *error) {
        @strongify(self);
            [self hiddenHUD];
            if (![error.domain isEqualToString:RACCommandErrorDomain]) {
                [self showBannerWithPrompt:error.domain];
            }
        } completed:^{
        @strongify(self);
            [self hiddenHUD];
            
            if (self.settingContentSaveBlock) {
                self.settingContentSaveBlock(self.contentType,self.contentTextField.text);
            }
            
            [self showBannerWithPrompt:@"昵称修改成功"];
            [self performSelector:@selector(backAction) withObject:nil afterDelay:0.5];
        }];
        
    }else{
        
        [self showBannerWithPrompt:@"昵称不能为空"];
    }
}

- (void)executeChangeGenderCommand{

    RACSignal *signal = [_contentViewModel changeGenderWithGenderType:_gender];
    
    [self showHUD];
    @weakify(self);
    [signal subscribeError:^(NSError *error) {
    @strongify(self);
        [self hiddenHUD];
        if (![error.domain isEqualToString:RACCommandErrorDomain]) {
            [self showBannerWithPrompt:error.domain];
        }
    } completed:^{
    @strongify(self);
        [self hiddenHUD];
        
        NSString *genderString = @"";
        if (self.gender == GenderMale) {
            genderString = @"1";
        }else if (self.gender == GenderFemale){
            genderString = @"2";
        }
        
        if (self.settingContentSaveBlock) {
            self.settingContentSaveBlock(self.contentType,genderString);
        }
        
        [self showBannerWithPrompt:@"性别修改成功"];
        [self performSelector:@selector(backAction) withObject:nil afterDelay:0.5];
    }];
}

- (void)executeChangeSummayCommand{

    NSString *text = _contentTextView.text;
    
    if ([JOTrimString(text) length] ) {
        
        [_contentTextView resignFirstResponder];
        
        RACSignal *signal = [_contentViewModel changeSummayWithContent:text];
        
        [self showHUD];
        @weakify(self);
        [signal subscribeError:^(NSError *error) {
        @strongify(self);
            [self hiddenHUD];
            if (![error.domain isEqualToString:RACCommandErrorDomain]) {
                [self showBannerWithPrompt:error.domain];
            }
        } completed:^{
        @strongify(self);
            [self hiddenHUD];
            [self showBannerWithPrompt:@"个人签名修改成功"];
            
            if (self.settingContentSaveBlock) {
                self.settingContentSaveBlock(self.contentType,JOTrimString(text));
            }
            
            [self performSelector:@selector(backAction) withObject:nil afterDelay:0.5];
        }];
    }else{
        
        [self showBannerWithPrompt:@"签名不能为空"];
    }
    
}

- (void)executeFeedbackCommand{

    NSString *text = _contentTextView.text;
    
    if ([JOTrimString(text) length] ) {
        
        [_contentTextView resignFirstResponder];
        [_contentTextField resignFirstResponder];
        RACSignal *signal = [_contentViewModel feedbackWithContent:text contact:_contentTextField.text];
        [self showHUD];
        @weakify(self);
        [signal subscribeError:^(NSError *error) {
        @strongify(self);
                [self hiddenHUD];
                if (![error.domain isEqualToString:RACCommandErrorDomain]) {
                    [self showBannerWithPrompt:error.domain];
                }
        } completed:^{
        @strongify(self);
            [self hiddenHUD];
            [self showBannerWithPrompt:@"提交成功"];
            [self performSelector:@selector(backAction) withObject:nil afterDelay:0.5];
        }];
    }else{
        
        [self showBannerWithPrompt:@"意见不能为空"];
    }
}

#pragma mark - block

- (void)settingContentSaveHandler:(SettingContentSaveBlock)sendBlock{

    self.settingContentSaveBlock = nil;
    self.settingContentSaveBlock = sendBlock;
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_contentTableDataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    [[cell textLabel] setText:[_contentTableDataArray objectAtIndex:indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    if (_gender == GenderMale && indexPath.row == 0) {
        //男性
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }else if (_gender == GenderFemale && indexPath.row == 1){
        //女性
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    return cell;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        _gender = GenderMale;
    }else if (indexPath.row == 1){
    
        _gender = GenderFemale;
    }
    [_contentTableView reloadData];
}

@end
