//
//  SubjectViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectViewController.h"
#import "SubjectModel.h"
#import "SubjectCell.h"
@interface SubjectViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *subjectTableView;

//数据源数组
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SubjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self requestDataWithPage:1];
}

#pragma mark - 懒加载
-(NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

#pragma mark - 初始化
-(instancetype)init {
    if (self = [super init]) {
        
        self.requestUrl = kSubjectUrl;
    }
    
    return self;
}

#pragma mark - 获取数据
//page 分页
//number 数量
- (void)requestDataWithPage:(NSInteger)page {
    [self.requestManager GET:self.requestUrl parameters:@{@"page" : [NSNumber numberWithInteger:page], @"number" : @5} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Subject_success:%@",responseObject);
        
        //将数组转化为模型数组
        NSArray *modelArray = [NSArray yy_modelArrayWithClass:[SubjectModel class] json:responseObject];
        
        //判断是否是刷新状态
        if ([self.subjectTableView.mj_header isRefreshing]) {
            [self.dataArray removeAllObjects];
        }
        
        
        //将数据存放到数据源数组中
        [self.dataArray addObjectsFromArray:modelArray];
        
        [self.subjectTableView.mj_header endRefreshing];
        [self.subjectTableView.mj_footer endRefreshing];
        
        //刷新数据
        [self.subjectTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Subject_failed:%@", error);
    }];
}

#pragma mark 创建界面
- (void)creatUI {
    
    //1.创建tableView
    self.subjectTableView = [[UITableView alloc]init];
    self.subjectTableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.subjectTableView];
    
    //添加约束
    __weak typeof(self) weakself = self;
    [self.subjectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakself.view);
    }];
    
    [self addMJRefresh];
    
    //设置代理
    self.subjectTableView.delegate = self;
    self.subjectTableView.dataSource = self;
    
    //设置行高
    [self.subjectTableView setRowHeight:324];
    
    //注册cell
    [self.subjectTableView registerNib:[UINib nibWithNibName:@"SubjectCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - TableView Datasource
//设置行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //设置行数
    return  self.dataArray.count;
}

//创建cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    SubjectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    //刷新数据
    cell.model = self.dataArray[indexPath.row];
    
    //返回cell
    return cell;
    
}

#pragma mark - 添加刷新控件
- (void)addMJRefresh {
    
    //下拉
    // 设置文字
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh:)];
    [header setTitle:@"你好好看啊" forState:MJRefreshStateIdle];
    [header setTitle:@"真是大美女" forState:MJRefreshStatePulling];
    [header setTitle:@"去哪儿" forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    
    self.subjectTableView.mj_header = header;
    
    //上拉
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(addMore:)];
    // 设置文字
    [footer setTitle:@"点击开始刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"开始加载更多" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经没有数据" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    footer.stateLabel.textColor = [UIColor blueColor];
    
    self.subjectTableView.mj_footer = footer;
}

#pragma mark - 下拉刷新
//下拉刷新
- (void)refresh:(MJRefreshGifHeader *)refresh {
    //[self.subjectTableView.mj_header endRefreshing];
    
    [self requestDataWithPage:1];
    
}

#pragma mark - 上拉加载更多
//上拉加载
- (void)addMore:(MJRefreshBackGifFooter *)addMore {
   //[self.subjectTableView.mj_footer endRefreshing];
    
    [self requestDataWithPage:self.dataArray.count / 5 + 1];
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
