//
//  UserCenterVC.m
//  才标网
//
//  Created by caohouhong on 17/3/20.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "UserCenterVC.h"
#import "UserCenterTableViewCell.h"
#import "GeRenZhongXingCell3.h"
#import "SettingViewController.h"
#import "PersonalInfoVC.h"
#import "RewardTaskVC.h"
#import "MasterTaskVC.h"
#import "IamMasterVC.h"
#import "ReviewResultVC.h"
#import "MessageViewController.h"
#import "WalletViewController.h"
#import "BrandFavourVC.h"
#import "MyContributeVC.h"
#import "TouGaoRenRenZhengVC.h"
#import "MyOrderVC.h"
#import "UserHelper.h"
#import "LoginViewController.h"
#import "ShareViewController.h"

@interface UserCenterVC ()<UITableViewDelegate, UITableViewDataSource,GeRenZhongXingCell3Delegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation UserCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@[@""],@[@"我的订单",@"复查结果",@"商标收藏",@"消息"],@[@"个人资料",@"钱包",@"投稿人认证",@"设置",@"分享"]];
    _imageArray = @[@[@""],@[@"uc_order_24x24",@"uc_find_24x24",@"uc_favour_24x24",@"uc_message_24x24"],@[@"uc_info_24x24",@"uc_money_24x24",@"uc_sure_24x24",@"uc_setting_24x24",@"uc_share_24x24"]];
    
    [self drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
  
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    _nameLabel.text = [UserHelper getMemberName];
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:[UserHelper getMemberHeaderPhoto]] placeholderImage:[UIImage imageNamed:@"uc_default_header_60x60"]];
    [self.tableView reloadData];
}



- (void)drawView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = HEXCOLOR(0xeeeeee);
    _tableView.tableHeaderView = self.headerView;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,-20)
    .bottomSpaceToView(self.view,0);
    
}

- (UIView *)headerView{
    
    if (!_headerView){
        
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 195*UIRate)];
        _headerView.backgroundColor = [UIColor clearColor];
        
        UIImageView *holdImageView = [[UIImageView alloc] initWithFrame:_headerView.frame];
        holdImageView.image = [UIImage imageNamed:@"uc_top_bg_375x295"];
        [_headerView addSubview:holdImageView];
        
        UIImageView *iconHoldView = [[UIImageView alloc] init];
        iconHoldView.image = [UIImage imageNamed:@"uc_icon_bg_65x65"];
        [_headerView addSubview:iconHoldView];
        
        _headerImageView = [[UIImageView alloc] init];
       
        [_headerView addSubview:_headerImageView];
        
        UIButton *headerButton = [[UIButton alloc] init];
        headerButton.backgroundColor = [UIColor clearColor];
        [headerButton addTarget:self action:@selector(headerButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:headerButton];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = SYSTEM_FONT_(15*UIRate);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        [_headerView addSubview:_nameLabel];
        
        iconHoldView.sd_layout
        .centerXEqualToView(_headerView)
        .topSpaceToView(_headerView,75*UIRate)
        .widthIs(65*UIRate)
        .heightIs(65*UIRate);

        _headerImageView.sd_layout
        .centerXEqualToView(_headerView)
        .centerYEqualToView(iconHoldView)
        .widthIs(60*UIRate)
        .heightIs(60*UIRate);
        _headerImageView.sd_cornerRadiusFromHeightRatio=@(0.5);

        
        _nameLabel.sd_layout
        .topSpaceToView(iconHoldView,20*UIRate)
        .centerXEqualToView(iconHoldView)
        .widthIs(200*UIRate)
        .heightIs(20*UIRate);
        
        headerButton.sd_layout
        .centerXEqualToView(_headerImageView)
        .centerYEqualToView(_headerImageView)
        .widthIs(80*UIRate)
        .heightIs(80*UIRate);
    }
    return _headerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = self.dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        GeRenZhongXingCell3 *cell = [GeRenZhongXingCell3 cellWithTableView:tableView];
        cell.delegate = self;
        return cell;
    }else {
        
        NSString * const cellIdentifier = @"CellIdentifier";
        UserCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[UserCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];
        cell.iconImageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
        
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0){
        return 90*UIRate;
    }
    return 50*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20*UIRate;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0://我的订单
            {
                MyOrderVC *vc = [[MyOrderVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1://复查结果
            {
                ReviewResultVC *vc = [[ReviewResultVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2://商标收藏
            {
                BrandFavourVC *vc = [[BrandFavourVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3://消息
            {
                MessageViewController *vc = [[MessageViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            default:
                break;
        }

    }else if (indexPath.section == 2){
        switch (indexPath.row) {
            case 0://个人资料
            {
                PersonalInfoVC *personalVC = [[PersonalInfoVC alloc] init];
                [self.navigationController pushViewController:personalVC animated:YES];
                
            }
                break;
            case 1://钱包
            {
                WalletViewController *vc = [[WalletViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2://投稿人认证
            {
                TouGaoRenRenZhengVC *vc = [[TouGaoRenRenZhengVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
            case 3://设置
            {
                SettingViewController *settingVC = [[SettingViewController alloc] init];
                [self.navigationController pushViewController:settingVC animated:YES];
            }
                break;
                
            case 4://分享
            {
                ShareViewController *shareVC = [[ShareViewController alloc] init];
                [self.navigationController pushViewController:shareVC animated:YES];
            }
            default:
                break;
        }
    }
}

#pragma mark - GeRenZhongXingCell3Delegate
- (void)GeRenZhongXingCell3ClickButtonWithTag:(int)tag
{
    switch (tag) {
        case 60000://悬赏任务
        {
            RewardTaskVC *vc = [[RewardTaskVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 60001://我的投稿
        {
            MyContributeVC *vc = [[MyContributeVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 60002://大师任务
        {
            MasterTaskVC *vc = [[MasterTaskVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 60003://我是大师
        {
            IamMasterVC *vc = [[IamMasterVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Action
//点击头像
- (void)headerButtonAction{
    PersonalInfoVC *personalVC = [[PersonalInfoVC alloc] init];
    [self.navigationController pushViewController:personalVC animated:YES];
}

@end
