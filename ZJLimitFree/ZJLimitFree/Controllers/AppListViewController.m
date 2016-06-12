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
@interface AppListViewController () <UISearchBarDelegate>

//表格视图
@property (nonatomic, strong) UITableView *appTableView;

@end

@implementation AppListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self addMJRefresh];
}

#pragma mark - 添加刷新控件
- (void)addMJRefresh {
    
    //下拉
    self.appTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进入刷新状态后会调用
        [self.appTableView.mj_header endRefreshing];
    }];
    
    //上拉
    self.appTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.appTableView.mj_footer endRefreshing];
    }];
}

#pragma mark - 按钮点击
//点击分类
- (void)category:(UIButton *)btn {
    
    //
    CategoryViewController *category = [[CategoryViewController alloc]init];
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
