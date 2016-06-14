//
//  SubjectCell.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectCell.h"
#import "SubjectModel.h"
#import "SubjectAppView.h"
@interface SubjectCell()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;

@property (weak, nonatomic) IBOutlet UIView *appListView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UITextView *descTextView;

@end


@implementation SubjectCell

- (void)awakeFromNib {
//    SubjectAppView *appView = [[SubjectAppView alloc]initWithFrame:CGRectMake(0, 0, self.appListView.frame.size.width, 50)];
//    [self.appListView addSubview:appView];
    
}

#pragma mark - 添加appList内容
- (void)addAppList {
    
    //清除appListView
    if (self.appListView.subviews.count > 0) {
        
        //让数组中的元素都去执行指定的方法
        //makeObjectsPerformSelector:@selector()
        
        [self.appListView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    CGFloat W = self.appListView.frame.size.width;
    
    CGFloat H = self.appListView.frame.size.height / 4.0f;
    
    CGFloat X = 0;
    
    //用block修饰才可以改值
    __block CGFloat Y;
    
    
    [self.model.applications enumerateObjectsUsingBlock:^(SubjectAppModel *obj, NSUInteger idx, BOOL *stop) {
        
        //计算Y
        Y = idx * (H + 5);
        
        SubjectAppView *appView = [[SubjectAppView alloc]initWithFrame:CGRectMake(X, Y, W, H)];
        
        [self.appListView addSubview:appView];
        
        appView.appModel = obj;
    }];
}

#pragma mark - 设置子视图的属性
-(void)setModel:(SubjectModel *)model {
    _model = model;
    
    //名字
    _nameLabel.text = model.title;
    
    //大图
    [_pictureImageView setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@""]];
    
    //icon
    [_iconImageView setImageWithURL:[NSURL URLWithString:model.desc_img] placeholderImage:[UIImage imageNamed:@""]];
    
    //描述
    _descTextView.text = model.desc;
    
    //appListView
    [self addAppList];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
