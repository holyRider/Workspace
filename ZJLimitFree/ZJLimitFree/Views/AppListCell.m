//
//  AppListCell.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/13.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "AppListCell.h"
#import <UIImageView+AFNetworking.h>
#import "AppListModel.h"
#import "ZJStartView.h"
@interface AppListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet ZJStartView *starView;

@end

@implementation AppListCell

//通过storyBoard或者xib的方式，创建界面。当界面将要显示出来的时候，会调用这个方法
- (void)awakeFromNib {
    // Initialization code
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.cornerRadius = 10;
    
    //使用自己的字体，来设置nameLabel
    //参数1:字体名
    //参数2:字体大小
    self.nameLabel.font = [UIFont fontWithName:@"HYZhuanShuF" size:17];
    
    //将字体文件添加到plist中，可以通过下面的代码找到字体名字(添加前后打印)
   // NSLog(@"%@", [UIFont familyNames]);
}

//给子控件的属性赋值
-(void)setModel:(AppListModel *)model {
    
    _model = model;
    
    //头像
    [self.iconImageView setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    //名字
    self.nameLabel.text = model.name;
    
    //日期
    self.dateLabel.text = model.releaseDate;
    
    //价格
    //self.priceLabel.text = model.lastPrice;
    
    //参数1:一般的字符串
    //参数2:属性
    NSAttributedString *attri = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@", model.lastPrice] attributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle), NSStrikethroughColorAttributeName : [UIColor redColor]}];
    //在label上显示富文本
    self.priceLabel.attributedText = attri;
    
    //类型
    self.typeLabel.text = model.categoryName;
    
    //数量
    self.countLabel.text = [NSString stringWithFormat:@"分享:%@  收藏:%@  下载:%@",model.shares, model.favorites, model.downloads];
    
    //星级
    self.starView.starValue = model.starCurrent;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
