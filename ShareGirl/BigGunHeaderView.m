//
//  BigGunHeaderView.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/11.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "BigGunHeaderView.h"

@implementation BigGunHeaderView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{
    
    self.userImage = [[UIImageView alloc]init];
    self.userImage.image = [UIImage imageNamed:@"logo"];
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 30;
    [self addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(60);
    }];
    
    self.teamButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.teamButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.teamButton setImage:[UIImage imageNamed:@"team"] forState:UIControlStateNormal];
    [self addSubview:self.teamButton];
    [self.teamButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(25);
    }];

    
    self.incomeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.incomeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.incomeButton setImage:[UIImage imageNamed:@"shouyi"] forState:UIControlStateNormal];
    [self addSubview:self.incomeButton];
    [self.incomeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self).offset(-25);
    }];

}
@end
