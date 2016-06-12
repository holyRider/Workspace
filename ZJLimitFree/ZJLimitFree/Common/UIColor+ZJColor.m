//
//  UIColor+ZJColor.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "UIColor+ZJColor.h"

@implementation UIColor(ZJColor)

+(UIColor *)colorWithR:(CGFloat)R
                     G:(CGFloat)G
                     B:(CGFloat)B {
    return [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:1];
}

+(UIColor *)colorWithR:(CGFloat)R
                     G:(CGFloat)G
                     B:(CGFloat)B
                 alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:R / 255.0f green:G / 255.0f blue:B / 255.0f alpha:alpha];
}

@end
