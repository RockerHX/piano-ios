//
//  MIAAlbumViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumViewController.h"
#import "MIACellManage.h"
#import "JOBaseSDK.h"

@interface MIAAlbumViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *albumTableView;

@end

@implementation MIAAlbumViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self createAlbumTableView];
}

- (void)createAlbumTableView{

    self.albumTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [_albumTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_albumTableView setBackgroundColor:[UIColor clearColor]];
    [_albumTableView setDataSource:self];
    [_albumTableView setDelegate:self];
    [_albumTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_albumTableView setSectionFooterHeight:CGFLOAT_MIN];
    [self.view addSubview:_albumTableView];
    
    [JOAutoLayout autoLayoutWithEdgeInsets:UIEdgeInsetsMake(0., 0., 0., 0.) selfView:_albumTableView superView:self.view];
}

#pragma mark - table data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MIABaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [MIACellManage getCellWithType:MIACellTypeAlbumDetail];
        [cell setCellWidth:View_Width(self.view)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [[cell textLabel] setText:@"text"];
    [cell setCellData:nil];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 800.;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
