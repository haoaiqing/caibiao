//
//  ClassificationVC.m
//  才标网
//
//  Created by baichun on 17/3/28.
//  Copyright © 2017年 李强. All rights reserved.
//

#import "ClassificationVC.h"
#import "ClassificationCell.h"
#import "CBConnect.h"
#import "ClassificationVC_2.h"
#import "ClassificationVC_3.h"
#import "NavigationView.h"

@interface ClassificationVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchResultsUpdating>
@property (nonatomic,strong) UITableView *tableView;
//搜索控制器
@property (nonatomic, strong) UISearchController *searchController;

//存放搜索列表中显示数据的数组
@property (strong,nonatomic) NSMutableArray  *searchList;


@property (strong,nonatomic) NSMutableArray  *seardataArray;

@end

@implementation ClassificationVC
-(NSMutableArray *)seardataArray{
    
    if (!_seardataArray) {
        _seardataArray = [NSMutableArray array];
    }
    return _seardataArray;
}
-(NSMutableArray *)searchList{
    
    if (!_searchList) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //不下沉
    if (self.isDealNav){
    self.navigationController.navigationBar.translucent = YES;
    }
    self.navigationItem.title = @"分类查询";
    [self drawView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.searchController.active = NO;
    self.searchController.searchBar.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.searchController.searchBar.hidden = NO;

    if (self.isDealNav){
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
}

-(void)drawView{
    
    //处理Nav
    __weak typeof (self) weakSelf = self;
    CGFloat offsetHeight = 0;
    if (self.isDealNav){
        NavigationView *nav = [[NavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64) andTitle:@"分类查询" block:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.view addSubview:nav];
        
        offsetHeight = 64;
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.sd_layout
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .topSpaceToView(self.view,offsetHeight)
    .bottomSpaceToView(self.view,0);
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    //设置代理对象
    _searchController.searchResultsUpdater = self;
    //设置搜索时，背景变暗色            _searchController.dimsBackgroundDuringPresentation = NO;
    //设置搜索时，背景变模糊
    _searchController.obscuresBackgroundDuringPresentation = NO;
//    隐藏导航栏
    _searchController.hidesNavigationBarDuringPresentation = NO;
    //设置搜索框的frame
    _searchController.searchBar.frame = CGRectMake(self.searchController.searchBar.frame.origin.x, self.searchController.searchBar.frame.origin.y, self.searchController.searchBar.frame.size.width, 44.0);
    //将搜索框设置为tableView的组头
  //  self.tableView.tableHeaderView = self.searchController.searchBar;
    
    for (TradeMarkCategoryModel *model in self.dataArray) {
        NSString *str = [NSString stringWithFormat:@"%@",model.category_name];
        [self.seardataArray addObject:str];
    }
}
    
#pragma mark - ======== <UITableViewDelegate,UITableViewDataSource> =========
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //如果searchController被激活就返回搜索数组的行数，否则返回数据数组的行数
//    if (self.searchController.active) {
//        return [self.searchList count];
//    }else{
        return [self.dataArray count];
  //  }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassificationCell *cell = [ClassificationCell cellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    TradeMarkCategoryModel *model = self.dataArray[indexPath.row];

    //如果搜索框被激活，就显示搜索数组的内容，否则显示数据数组的内容
//    if (self.searchController.active) {
//        [cell.titleLabel setText:self.searchList[indexPath.row]];
//    }
//    else{
        [cell setModle:model IndexPath:indexPath];
    //}
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchController.active = NO;
    
    TradeMarkCategoryModel *model = self.dataArray[indexPath.row];
    ClassificationVC_2 *vc = [[ClassificationVC_2 alloc]init];
    vc.filter_parent_id = model.sid;
    vc.titleText = model.category_name;
    vc.category_title = model.category_title;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//执行过滤操作
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    //获取搜索框中用户输入的字符串
    NSString *searchString = [self.searchController.searchBar text];
    //指定过滤条件，SELF表示要查询集合中对象，contain[c]表示包含字符串，%@是字符串内容
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    //如果搜索数组中存在对象，即上次搜索的结果，则清除这些对象
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //通过过滤条件过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[self.seardataArray filteredArrayUsingPredicate:preicate]];
    
   
    //刷新表格
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
