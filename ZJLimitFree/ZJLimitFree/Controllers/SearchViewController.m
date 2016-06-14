//
//  SearchViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SearchViewController.h"
#import "AppListModel.h"
#import "AppListCell.h"

@interface SearchViewController ()<UITableViewDataSource, UITableViewDelegate>

//数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *searchTableView;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.requestUrl);
    [self requestDataWithPage:1 search:self.searchText cateId:@""];
}

#pragma mark - tableView Datasource
-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    AppListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //刷新数据
    cell.model = self.dataArray[indexPath.row];
    
    //返回cell
    return cell;
    
}

#pragma mark - tableView Delegate
//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //算出cell的高度比(在6上是135)
    CGFloat scale = 135 / 667.0f;
    
    //根据不同的屏幕尺寸设置cell的高度
    return scale * self.view.frame.size.height;
}

#pragma mark - 创建界面
-(void)creatUI {
    
    //1.tableView
    self.searchTableView = [[UITableView alloc]init];
    
    [self.view addSubview:self.searchTableView];
    
    self.searchTableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    __weak typeof(self) weakself = self;
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    
    //设置代理
    self.searchTableView.dataSource = self;
    self.searchTableView.delegate = self;
    
    //注册cell
    [self.searchTableView registerNib:[UINib nibWithNibName:@"AppListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //2.设置title
    self.title = @"收索结果";
    
    //3.设置返回按钮
    [self addNavigationItemWithTitle:@"返回" isBack:YES isRight:NO target:self action:@selector(backLastView)];
    
    //4.添加刷新控件
    [self addMJRefresh];
}

#pragma mark - 懒加载
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

#pragma mark - 获取数据
- (void)requestDataWithPage:(NSInteger)page
                     search:(NSString *)search
                     cateId:(NSString *)cateId {
    
    NSDictionary *dict = @{@"page" : @(page), @"number" : @20, @"search" : self.searchText};
    
    [self.requestManager GET:self.requestUrl parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
       // NSLog(@"search_success:%@", responseObject);
        
        //获取字典数组
        NSArray *dictArray = responseObject[@"applications"];
        
        //将字典数组转换成模型数组
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[AppListModel class] json:dictArray];
        
        if ([self.searchTableView.mj_header isRefreshing]) {
            [self.dataArray removeAllObjects];
        }
        
        //将模型数组中的数据放到数据源数中
        [self.dataArray addObjectsFromArray:modelArray];
        
        //停止刷新和加载更多
        [self.searchTableView.mj_header endRefreshing];
        [self.searchTableView.mj_footer endRefreshing];
        
        //刷新数据
        [self.searchTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
       // NSLog(@"search_failed:%@", error);
    }];
    
}

#pragma mark - 添加刷新控件
- (void)addMJRefresh {
    
    //下拉
    self.searchTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进入刷新状态后会调用这个block
        
        //重新请求数据
        [self requestDataWithPage:1 search:self.searchText cateId:@""];
    }];
    
    //上拉
    self.searchTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        NSInteger page = self.dataArray.count / 20 + 1;
        [self requestDataWithPage:page search:self.searchText cateId:@""];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
