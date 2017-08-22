//
//  MostNewAndHotCell.m
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/4.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "MostNewAndHotCell.h"
#import "VedioModel.h"
@implementation MostNewAndHotCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setChildView];
        
    }
    return self;
}
-(void)setChildView{
    self.titleImage = [[UIImageView alloc]init];
//    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://59.110.48.164:8001/Images/HomePage/indexPic.png"]]];
//    self.titleImage.image = image;
    self.titleImage.layer.masksToBounds = YES;
    self.titleImage.layer.cornerRadius = 8;
    [self.contentView addSubview:self.titleImage];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.height.mas_equalTo(183*Height);
    }];
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"美女Lo的套路";
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.titleImage.mas_bottom).offset(-10);
        make.left.equalTo(self.contentView).offset(10);
    }];
    self.subImage = [[UIImageView alloc]init];
    self.subImage.backgroundColor = [UIColor redColor];
    self.subImage.layer.masksToBounds = YES;
    self.subImage.layer.cornerRadius = 20;
    [self.contentView addSubview:self.subImage];
    [self.subImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.titleImage.mas_bottom).offset(5);
        make.bottom.equalTo(self.contentView).offset(-5);
        make.width.and.height.mas_equalTo(40);
    }];
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"蒙奇奇";
    self.nameLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subImage.mas_right).offset(5);
        make.centerY.equalTo(self.subImage.mas_centerY);
    }];
    
    
    
    self.vedioNumber = [[UILabel alloc]init];
    self.vedioNumber.font = [UIFont systemFontOfSize:10];
    [self.contentView addSubview:self.vedioNumber];
    [self.vedioNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self.subImage.mas_centerY);
    }];
    
    self.vedioImage = [[UIImageView alloc]init];
//    self.vedioImage.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.vedioImage];
    [self.vedioImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.vedioNumber.mas_left).offset(-5);
        make.centerY.equalTo(self.subImage.mas_centerY);
        make.width.and.height.mas_equalTo(20);
  }];
    
}
-(void)setVedioModel:(VedioModel *)vedioModel{
    _vedioModel = vedioModel;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:[vedioModel.ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.textLabel.text = vedioModel.Title;
    
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
