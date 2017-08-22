//
//  HomeCell.m
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/4.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "HomeCell.h"

@implementation HomeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}
-(void)allViews{
    self.picImage = [[UIImageView alloc]init];
    self.picImage.layer.masksToBounds = YES;
    self.picImage.layer.cornerRadius = 8;
    [self.contentView addSubview:self.picImage];
    [self.picImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.right.equalTo(self.contentView);
         make.bottom.equalTo(self.picImage.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    
    
    self.userImage = [[UIImageView alloc]init];
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 15;
    [self.contentView addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picImage.mas_left).offset(5);
        make.bottom.equalTo(self.picImage.mas_bottom).offset(-5);
        make.width.height.mas_equalTo(30);
    }];
    
    
    self.userLabel = [[UILabel alloc]init];
    self.userLabel.text  = @"羽希子";
    self.userLabel.font = [UIFont systemFontOfSize:12];
    self.userLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:self.userLabel];
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImage.mas_right).offset(5);
        make.right.equalTo(self.picImage.mas_right);
        make.centerY.equalTo(self.userImage.mas_centerY);
    }];
    
    
    

}

@end
