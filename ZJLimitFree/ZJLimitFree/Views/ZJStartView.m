//
//  ZJStartView.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "ZJStartView.h"

@interface ZJStartView ()

@property (nonatomic, strong) UIImageView *backgroundView;

@property (nonatomic, strong) UIImageView *foregroundView;

@end

@implementation ZJStartView

#pragma mark - 初始化
//通过storyBoard或者xib去创建视图的时候，会调用这个方法
//在这个方法中可以拿到当前视图的frame
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        //NSLog(@"%@", NSStringFromCGRect(self.frame));
        //实例化子视图
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsBackground"]];
        
        [self addSubview:self.backgroundView];
        
        self.foregroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"StarsForeground"]];
        
        [self addSubview:self.foregroundView];
        
    }
    
    return self;
}

//从外部给starValue赋值，然后根据starValue的值设置foregroundView的宽度
- (void)setStarValue:(NSString *)starValue {
    
    _starValue = starValue;
    //获取原来的位置信息
    CGRect rect = self.backgroundView.frame;
    CGFloat realW = rect.size.width * (starValue.floatValue / 5.0f);
    
    //更新frame
    self.foregroundView.frame = CGRectMake(rect.origin.x, rect.origin.y, realW, rect.size.height);
    
    //设置显示模式是将图片的左边显示全(默认的是缩放)
    [self.foregroundView setContentMode:UIViewContentModeLeft];
    
    //允许剪裁
    self.foregroundView.clipsToBounds = YES;
}

@end
