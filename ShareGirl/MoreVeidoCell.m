//
//  MoreVeidoCell.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/13.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "MoreVeidoCell.h"

@implementation MoreVeidoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}
-(void)allViews{

    self.titleImage = [[UIImageView alloc]init];
    self.titleImage.layer.masksToBounds = YES;
    self.titleImage.layer.cornerRadius = 8;
    [self.contentView addSubview:self.titleImage];
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.contentView);
    }];
    
}
@end
