//
//  CustomTabBarController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "CustomTabBarController.h"
#import "LimitViewController.h"
#import "ReductionViewController.h"
#import "FreeViewController.h"
#import "SubjectViewController.h"
#import "HotViewController.h"
#import "CustomNavigationController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视图控制器
    [self creatControllers];
    
    //设置界面
    [self creatUI];
    
}

#pragma mark - 创建界面
- (void)creatUI {
    
    //设置TabBar的背景
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg"]];
    
    //设置TabBar的文字颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:60 / 255.0f green:130 / 255.0f blue:200 / 255.0 alpha:1.0]}];
    
    //设置tabBar上的文字选中颜色
    [self.tabBar setTintColor:[UIColor colorWithRed:60 / 255.0f green:130 / 255.0f blue:200 / 255.0f alpha:1.0]];
}

#pragma mark - 创建视图控制器
- (void)creatControllers {
    
    //1.拿到plist文件
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Controllers.plist" ofType:nil];
    
    //2.获取数组
    NSArray *plistArray = [NSArray arrayWithContentsOfFile:path];
    
    //3.遍历数组(通过枚举的方式遍历数组)
    [plistArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        NSString *className = obj[@"className"];
        NSString *title = obj[@"title"];
        NSString *imageName = obj[@"imageName"];
        
        //将类型名转换为类,runtime的方法
        Class zjClass =  NSClassFromString(className);
        
        UIViewController *controller = [[zjClass alloc]init];
        
        //设置tabBarItem的属性
        controller.title = title;
        controller.tabBarItem.image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        controller.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_press", imageName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //添加到tabBarController
        CustomNavigationController *nav = [[CustomNavigationController alloc]initWithRootViewController:controller];
        [self addChildViewController:nav];
        
    }];
}








@end
