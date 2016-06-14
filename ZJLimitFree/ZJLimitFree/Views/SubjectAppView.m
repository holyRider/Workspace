//
//  SubjectAppView.m
//  ZJLimitFree
//
//  Created by 千锋 on 16/6/14.
//  Copyright (c) 2016年 千锋. All rights reserved.
//

#import "SubjectAppView.h"
#import "ZJStartView.h"
#import "SubjectModel.h"

@interface SubjectAppView()

//头像
@property (nonatomic, strong) UIImageView *iconImageView;

//名字
@property (nonatomic, strong) UILabel *nameLabel;

//评论
@property (nonatomic, strong) UILabel *commentLabel;

//下载
@property (nonatomic, strong) UILabel *downloadLabel;

//星级
@property (nonatomic, strong) ZJStartView *starView;

@end



@implementation SubjectAppView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self creatSubView];
    }
    return self;
}

-(void)layoutSubviews {
    
    [self calculateFrame];
}

#pragma mark - 给子视图的属性赋值
- (void)setAppModel:(SubjectAppModel *)appModel {
   
    _appModel = appModel;
    
    //头像
    [_iconImageView setImageWithURL:[NSURL URLWithString:appModel.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    
    //名字
    _nameLabel.text = appModel.name;
    
    //评论
    _commentLabel.attributedText = [self mixImage:[UIImage imageNamed:@"topic_Comment"] text:[NSString stringWithFormat:@" %@", appModel.ratingOverall]];
    
    //下载
    _downloadLabel.attributedText = [self mixImage:[UIImage imageNamed:@"topic_Download"] text:[NSString stringWithFormat:@" %@",appModel.downloads] ];
    
    //星级
    _starView.starValue = appModel.starOverall;
}

#pragma mark - 图文混排
- (NSAttributedString *)mixImage:(UIImage *)image text:(NSString *)text {
    
    //将图片转换成文本附件
    NSTextAttachment *imageMent = [[NSTextAttachment alloc]init];
    imageMent.image = image;
    
    //2.将文本附件转换成富文本
    NSAttributedString *imageAttri = [NSAttributedString attributedStringWithAttachment:imageMent];
    
    //3.将文字转换成富文本
   NSAttributedString *textAttri = [[NSAttributedString alloc]initWithString:text attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:9], NSForegroundColorAttributeName : [UIColor grayColor]}];
    
       //4.将文字富文本和图片富文本拼接在一起
    NSMutableAttributedString *mixAttri = [NSMutableAttributedString new];
    [mixAttri appendAttributedString:imageAttri];
    [mixAttri appendAttributedString:textAttri];
    
    return mixAttri;
                                                                                                
}

#pragma mark - 创建子视图
- (void)creatSubView {
    
    //头像
    _iconImageView = [[UIImageView alloc]init];
    [self addSubview:_iconImageView];
    
    //名字
    _nameLabel = [[UILabel alloc]init];
    [self addSubview:_nameLabel];
    
    //评论
    _commentLabel = [[UILabel alloc]init];
    [self addSubview:_commentLabel];
    
    //下载
    _downloadLabel = [[UILabel alloc]init];
    [self addSubview:_downloadLabel];
    
    //星级
    _starView = [[ZJStartView alloc]init];
    [self addSubview:_starView];
    
}

#pragma mark - 计算子视图的frame
- (void)calculateFrame {
    
    __weak typeof(self) weakself = self;
    
    //头像
    
    _iconImageView.translatesAutoresizingMaskIntoConstraints = NO;
   // _iconImageView.backgroundColor= [UIColor orangeColor];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //设置上下左边距
        make.left.equalTo(weakself.mas_left);
        make.top.equalTo(weakself.mas_top);
        make.bottom.equalTo(weakself.mas_bottom);
        
        //让高度和宽度相等
        make.width.equalTo(_iconImageView.mas_height);
        
    }];
    
    //名字
    
    _nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //_nameLabel.backgroundColor= [UIColor cyanColor];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //设置左边距
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        //设置上边距
        make.top.equalTo(weakself.mas_top);
        
        //设置右边距
        make.right.equalTo(weakself.mas_right).offset(-5);
        
        //名字高度是当前这个视图的高度的1/3
        make.height.equalTo(weakself.mas_height).multipliedBy(1/3.0f);
    }];
    
    //评论
    
    _commentLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //_commentLabel.backgroundColor= [UIColor purpleColor];
    
    
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //设置左边距
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        
        //设置高度
        make.height.equalTo(_nameLabel);
        
        //y方向的中心等于头像的Y方向的中心
        make.centerY.equalTo(_iconImageView.mas_centerY);
        
        //设置宽度
        CGFloat commentW = self.frame.size.width / 3.0f;
        make.width.equalTo(@(commentW));
        
    }];
    
    //下载
    
    _downloadLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //_downloadLabel.backgroundColor= [UIColor redColor];
    
    [_downloadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(_commentLabel);
        
        make.centerY.equalTo(_iconImageView.mas_centerY);
        
        //make.width.equalTo(_commentLabel.mas_width);
        
        make.right.equalTo(weakself.mas_right).offset(-5);
        
        make.left.equalTo(_commentLabel.mas_right).offset(5);
        
    }];
    
    
    //星级
    
    _starView.translatesAutoresizingMaskIntoConstraints = NO;
    //_starView.backgroundColor= [UIColor blueColor];
    
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_iconImageView.mas_right).offset(5);
        
        make.right.equalTo(weakself.mas_right).offset(-5);
        
        make.height.equalTo(_nameLabel);
        
        make.bottom.equalTo(_iconImageView);
        
    }];
}


@end
