//
//  TransactionRecordsCell.m
//  mtopt.Lixiangguo.Wealth
//
//  Created by 姜鸥人 on 2017/5/15.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "TransactionRecordsCell.h"

@implementation TransactionRecordsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setChildView];
    }
    return self;
}

-(void)setChildView{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"申请提现";
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(self.contentView).offset(10);
    }];
    self.timeLabel = [[UILabel alloc]init];
    self.timeLabel.text = @"2017-5-5";
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel).offset(25);
    }];
    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.text = @"-10000";
    self.numberLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(60);
         make.centerY.equalTo(self.contentView);
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
