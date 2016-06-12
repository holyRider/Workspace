//
//  CategoryViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@property (nonatomic, strong) UITableView *categoryTableView;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - 创建界面
- (void)creatUI {
    
    //1.设置标题
    self.title = @"分类";
    
    //2.设置navigationItem
    [self addNavigationItemWithTitle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
    
    //3.创建tableView
    self.categoryTableView = [[UITableView alloc]init];
    self.categoryTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.categoryTableView];
    
    //添加约束
    __weak typeof(self) weakself = self;
    [self.categoryTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    
    [self addMJRefresh];
}

#pragma mark - 添加刷新控件
- (void)addMJRefresh {
    
    //下拉
    self.categoryTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进入刷新状态后会调用
        [self.categoryTableView.mj_header endRefreshing];
    }];
    
    //上拉
    self.categoryTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.categoryTableView.mj_footer endRefreshing];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
