//
//  AppListViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "AppListViewController.h"
#import "SettingsViewController.h"
#import "CategoryViewController.h"
#import "SearchViewController.h"
#import "AppListModel.h"
#import "AppListCell.h"

@interface AppListViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>

//表格视图
@property (nonatomic, strong) UITableView *appTableView;

//数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requestDataWithPage:1 search:@"" cateId:@""];
}

#pragma mark -懒加载
-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

#pragma mark - 数据请求
- (void)requestDataWithPage:(NSInteger)page search:(NSString *)search cateId:(NSString *)cateId {
    
    //请求数据
    NSDictionary *dict = @{@"page" : [NSNumber numberWithInteger:page], @"number" : @20, @"search" : search};
    
    //@"cate_id" : cateId
    if (self.cateId.length > 0) {
        dict = @{@"page" : [NSNumber numberWithInteger:page], @"number" : @20, @"search" : search, @"cate_id" : self.cateId};
    }
    
    [self.requestManager GET:self.requestUrl parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"AppList_success");
       // NSLog(@"---%@", responseObject);
        
        //获取字典数组
        NSArray *plistArray = responseObject[@"applications"];
        
        //将字典数组转化为模型数组
        //参数1:模型的类型
        //参数2:需要转化的数组
        NSArray *appArray = [NSArray yy_modelArrayWithClass:[AppListModel class] json:plistArray];
        //NSLog(@"%@", appArray);
//        for (AppListModel *model in appArray) {
//            NSLog(@"%@", model);
//        }
        
        if ([self.appTableView.mj_header isRefreshing]) {
            //删除之前的数据
            [self.dataArray removeAllObjects];
        }
        
        //将模型放到数据源数组中
        [self.dataArray addObjectsFromArray:appArray];
        
        //停止刷新
        [self.appTableView.mj_header endRefreshing];
        [self.appTableView.mj_footer endRefreshing];
        
        //刷新界面
        [self.appTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"APPList_failed:%@", error);
    }];
    
}

#pragma mark - 创建界面
- (void)creatUI {
    
    
    //1.设置navigationBarItem
    //分类
    [self addNavigationItemWithTitle:@"分类" isBack:NO isRight:NO target:self action:@selector(category:)];
    
    //设置
    [self addNavigationItemWithTitle:@"设置" isBack:NO isRight:YES target:self action:@selector(setting:)];
    
    //2.创建tableView
    self.appTableView = [[UITableView alloc]init];
    
    self.appTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.appTableView];
    //添加约束
    __weak typeof(self) weakself = self;
    [self.appTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       //同时添加上下左右的边距
        make.edges.equalTo(weakself.view);
    }];
    
    //3.添加搜索框
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
    searchBar.showsCancelButton = YES;
    searchBar.placeholder = @"百万应用等你来搜索哟";
    searchBar.delegate = self;
    
    self.appTableView.tableHeaderView = searchBar;
    
    //添加刷新控件
    [self addMJRefresh];
    
    //设置代理
    self.appTableView.delegate = self;
    self.appTableView.dataSource = self;
    //设置cell的高度
    self.appTableView.rowHeight = 135;
    [self.appTableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

#pragma mark - tableView Datasuorce
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //去复用池中查看是否可以有复用的cell，如果有直接返回。如果没有就创建一个新的返回
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //更新数据
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - 添加刷新控件
- (void)addMJRefresh {
    
    //下拉
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进入刷新状态后会调用这个block
        
        //重新请求数据
        [self requestDataWithPage:1 search:@"" cateId:@""];
    }];
    
    //上拉
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSInteger page = self.dataArray.count / 20 + 1;
        [self requestDataWithPage:page search:@"" cateId:@""];
    }];
}

#pragma mark - 按钮点击
//点击分类
- (void)category:(UIButton *)btn {
    
    //跳转到分类界面
    CategoryViewController *category = [[CategoryViewController alloc]init];
    
    //实现下一级界面block
    category.sendValue = ^(NSString *cateId){
        //[self requestDataWithPage:0 search:@"" cateId:cateId];
        
        self.cateId = cateId;
        NSLog(@"+++%@", self.cateId);
        [self.appTableView.mj_header beginRefreshing];
    };
    category.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:category animated:YES];
}

//点击设置
- (void)setting:(UIButton *)btn {
    
    //
    SettingsViewController *settings = [[SettingsViewController alloc]init];
    settings.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:settings animated:YES];
}

#pragma mark - SearchBar Delegate
//点击搜索按钮会调用的方法
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    //收起键盘
    [searchBar resignFirstResponder];
    
    //进入搜索页
    SearchViewController *search = [[SearchViewController alloc]init];
    
    //传值
    search.requestUrl = self.requestUrl;
    search.searchText = searchBar.text;
    search.hidesBottomBarWhenPushed = YES;
    
    //跳转
    [self.navigationController pushViewController:search animated:YES];
    
   
}

//点取消按钮会调用的方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    //收起键盘
    [searchBar resignFirstResponder];
    
    //清空文字
    searchBar.text = nil;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
