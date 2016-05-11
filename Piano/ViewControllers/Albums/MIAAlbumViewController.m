//
//  MIAAlbumViewController.m
//  Piano
//
//  Created by 刘维 on 16/5/11.
//  Copyright © 2016年 Mia Music. All rights reserved.
//

#import "MIAAlbumViewController.h"
#import "MIAAlbumDetailView.h"
#import "MIACellManage.h"
#import "JOBaseSDK.h"

@interface MIAAlbumViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *albumTableView;
@property (nonatomic, strong) MIAAlbumDetailView *albumTableHeadView;

@end

@implementation MIAAlbumViewController

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)loadView{

    [super loadView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self createAlbumTableHeadView];
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

- (void)createAlbumTableHeadView{

    self.albumTableHeadView = [[MIAAlbumDetailView alloc] init];
    [_albumTableHeadView setFrame:CGRectMake(0., 0., View_Width(self.view), [_albumTableHeadView albumDetailViewHeight])];
    
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
        
        cell = [MIACellManage getCellWithType:MIACellTypeAlbumSong];
        [cell setCellWidth:View_Width(self.view)];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
//    [[cell textLabel] setText:@"text"];
    [cell setCellData:nil];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return _albumTableHeadView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        
        return [_albumTableHeadView albumDetailViewHeight];
    }else{
    
        return 20.;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100.;
}

#pragma mark - table delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end
