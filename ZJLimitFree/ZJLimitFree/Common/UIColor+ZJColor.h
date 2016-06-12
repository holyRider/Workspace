//
//  UIColor+ZJColor.h
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/12.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor(ZJColor)

+ (UIColor *)colorWithR:(CGFloat)R
                      G:(CGFloat)G
                      B:(CGFloat)B;

+ (UIColor *)colorWithR:(CGFloat)R
                      G:(CGFloat)G
                      B:(CGFloat)B
                  alpha:(CGFloat)alpha;

@end
