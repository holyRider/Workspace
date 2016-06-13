//
//  LimitViewController.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "LimitViewController.h"

@interface LimitViewController ()

@end

@implementation LimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(instancetype)init {
    if (self = [super init]) {
        
        self.requestUrl = kLimitUrl;
    }
    
    return self;
}

@end
