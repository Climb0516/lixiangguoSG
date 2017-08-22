//
//  TopView.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/12.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "TopView.h"

@implementation TopView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupView];
    }
    return self;
}
-(void)setupView{
    self.backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(5);
        make.left.equalTo(self).offset(10);
        make.width.height.mas_equalTo(40);
    }];
}
@end
