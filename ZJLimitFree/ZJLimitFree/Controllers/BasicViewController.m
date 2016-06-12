//
//  BasicViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景颜色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self creatUI];
}

#pragma mark - 创建界面
- (void)creatUI {
    
}

#pragma mark - 添加navgationItem
-(void)addNavigationItemWithTitle:(NSString *)title
                           isBack:(BOOL)isBack
                          isRight:(BOOL)isRight
                           target:(id)target
                           action:(SEL)action {
    
    //通过自定制按钮去创建
    UIButton *button = [[UIButton alloc]init];
    
    //根据是否是返回按钮设置不同的大小和背景图片
    if (isBack) {
        button.frame = CGRectMake(0, 0, 63, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    }else {
        button.frame = CGRectMake(0, 0, 44, 30);
        [button setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    }
    
    //设置文字
    [button setTitle:title forState:UIControlStateNormal];
    
    //设置文字颜色
//    [button setTitleColor:[UIColor colorWithRed:61 / 255.0f green:40 /255.0f blue:60 / 255.0f alpha:1.0] forState:UIControlStateNormal];
    
    [button setTitleColor:[UIColor colorWithR:61 G:40 B:60] forState:UIControlStateNormal];
    
    //设置文字字体
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    
    //添加按钮的点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //根据按钮创建UIBarButtonItem
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:button];
    
    //显示item
    if (isRight) {
        [self.navigationItem setRightBarButtonItem:item];
    }else {
        [self.navigationItem setLeftBarButtonItem:item];
    }
}


#pragma mark - 返回上一页
-(void)backLastView {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
