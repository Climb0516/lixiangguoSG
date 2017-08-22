//
//  DayTaskCell.h
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/6.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTaskCell : UITableViewCell


@property(nonatomic,strong)UILabel *numberLabel;
@property(nonatomic,strong)UILabel *taskLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;


@property(nonatomic,assign)BOOL isHiden;

@end
