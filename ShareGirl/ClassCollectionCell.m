//
//  ClassCollectionCell.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/21.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ClassCollectionCell.h"

@implementation ClassCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}
-(void)allViews{
    
    self.imageView = [[UIImageView alloc]init];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 30;
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(5);
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.width.height.mas_equalTo(60);
    }];
    self.LabelTitle = [[UILabel alloc]init];
    self.LabelTitle.text = @"美夕";
    self.LabelTitle.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.LabelTitle];
    [self.LabelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
    }];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

@end
