//
//  ProViewCell.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/24.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ProViewCell.h"

@implementation ProViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setChildView];
    }
    return self;
}


-(void)setChildView{
    self.proImage =[[UIImageView alloc]init];
    [self.contentView addSubview:self.proImage];
    [self.proImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
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
