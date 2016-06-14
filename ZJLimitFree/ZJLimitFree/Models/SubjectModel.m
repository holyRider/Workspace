//
//  SubjectModel.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectModel.h"

@implementation SubjectAppModel



@end

@implementation SubjectModel

//将当前模型中的指定的容器属性的元素，转换成指定的类型
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    //将applications属性的数组元素，转换成其后的类型
    return  @{@"applications" : [SubjectAppModel class]};
}

@end
