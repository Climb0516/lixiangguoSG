//
//  subView.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/13.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "subView.h"

@implementation subView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupView];
        self.userInteractionEnabled = YES;
    }
    return self;
}
-(void)setupView{
    
    self.labelOne = [[UILabel alloc]init];
    self.labelOne.font = [UIFont systemFontOfSize:13];
    [self addSubview:self.labelOne];
    
    
    self.view1 = [[UIView alloc]init];
    self.view1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self addSubview:self.view1];
    [self.view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self).offset(15);
         make.bottom.equalTo(self).offset(-10);
        make.width.mas_equalTo(1);
    }];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.backgroundColor = [UIColor clearColor];
    [self addSubview:self.button];

}

-(void)layoutSubviews {
    [super layoutSubviews];

    [self.labelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
}

@end
