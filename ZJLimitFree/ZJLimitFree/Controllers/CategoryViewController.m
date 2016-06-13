//
//  CategoryViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "CategoryViewController.h"
#import <UIImageView+AFNetworking.h>
@interface CategoryViewController ()<UITableViewDelegate, UITableViewDataSource>

//表格视图
@property (nonatomic, strong) UITableView *categoryTableView;

//数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

#pragma mark - tableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //拿到模型
    CategoryModel *model = self.dataArray[indexPath.row];
    
    self.sendValue(model.categoryId);
    
    //返回上一个界面
    [self backLastView];
    
}

#pragma mark - tableView Datasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    //刷新数据
    CategoryModel *model = self.dataArray[indexPath.row];
    
    [cell.imageView setImageWithURL:[NSURL URLWithString:model.picUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    cell.textLabel.text = model.categoryCname;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"共%@款应用，其中限免%@款", model.categoryCount, model.limited];
    
    return cell;
}

#pragma mark - 懒加载
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

#pragma mark - 网络请求
- (void)requestData {
    [self.requestManager GET:kCateUrl parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //NSLog(@"cate:%@", responseObject);
        
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[CategoryModel class] json:responseObject];
        //NSLog(@"==%@", modelArray);
        
        [self.dataArray addObjectsFromArray:modelArray];
        
        [self.categoryTableView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"failed:%@", error);
    }];
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
    
    //添加刷新控件
    [self addMJRefresh];
    
    //设置代理
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    
    //设置行高
    self.categoryTableView.rowHeight = 100;
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
