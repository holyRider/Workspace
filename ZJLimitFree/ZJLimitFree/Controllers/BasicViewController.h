//
//  BasicViewController.h
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

//请求路径
@property (nonatomic, strong) NSString *requestUrl;

//
@property (nonatomic, strong) AFHTTPSessionManager *requestManager;

//添加navigationItem
- (void) addNavigationItemWithTitle:(NSString *)title isBack:(BOOL)isBack isRight:(BOOL)isRight target:(id)target action:(SEL)action;

//创建界面
- (void)creatUI;

//返回上一页
- (void)backLastView;

@end
