//
//  DayTaskCell.m
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/6.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "DayTaskCell.h"

@implementation DayTaskCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setChildView];
        
        
    }
    return self;
}
-(void)setChildView{

    
    self.numberLabel = [[UILabel alloc]init];
    self.numberLabel.text = @"今日收益";
    self.numberLabel.font = [UIFont systemFontOfSize:13];
     [self.contentView addSubview:self.numberLabel];
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(20);
    }];
    
    self.taskLabel = [[UILabel alloc]init];
    self.taskLabel.text = @"余额:2344.00";
    self.taskLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.taskLabel];
    [self.taskLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.top.equalTo(self.numberLabel.mas_bottom).offset(5);
    }];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"2017-07-19";
    self.titleLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.numberLabel.mas_centerY);
    }];
    
    self.contentLabel = [[UILabel alloc]init];
    self.contentLabel.text = @"+1100";
    self.contentLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
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
