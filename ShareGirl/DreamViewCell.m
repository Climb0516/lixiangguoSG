//
//  DreamViewCell.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/28.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "DreamViewCell.h"

@implementation DreamViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setChildView];
    }
    return self;
}
-(void)setChildView{

    
    self.userImage = [[UIImageView alloc]init];
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 25;
    self.userImage.image = [UIImage imageNamed:@"touxiang"];
    [self.contentView addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_right).offset(15);
        make.width.height.mas_equalTo(50);
        
    }];
    
    self.userName = [[UILabel alloc]init];
    self.userName.text = @"希希拉贝";
    self.userName.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImage.mas_centerY).offset(-10);
        make.left.equalTo(self.userImage.mas_right).offset(10);
    }];
    
     self.labelType = [[UILabel alloc]init];
    self.labelType.text = @"VIP";
    self.labelType.textColor  = [UIColor whiteColor];
    self.labelType.font = [UIFont systemFontOfSize:13];
    self.labelType.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.labelType];
    [self.labelType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(10);
        make.left.equalTo(self.userName);
    }];
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.text = @"20";
    self.numberLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.labelType.mas_centerY);
        make.left.equalTo(self.labelType.mas_right).offset(5);
    }];
    
    UIView *gray = [[UIView alloc]init];
    gray.backgroundColor  =[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.contentView addSubview:gray];
    [gray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.right.bottom.equalTo(self.contentView);
    }];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
