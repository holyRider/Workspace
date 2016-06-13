//
//  AppListModel.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "AppListModel.h"

@implementation AppListModel

//定制属性的映射
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"descrip":@"description"};
}

- (NSString *)description {
    return self.descrip;
}

@end
