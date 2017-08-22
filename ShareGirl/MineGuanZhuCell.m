//
//  MineGuanZhuCell.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/3.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "MineGuanZhuCell.h"

@implementation MineGuanZhuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.guanzuhCell.layer.masksToBounds = YES ;
    self.guanzuhCell.layer.cornerRadius = 8;
}

@end
