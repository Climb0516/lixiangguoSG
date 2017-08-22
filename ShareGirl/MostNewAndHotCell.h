//
//  MostNewAndHotCell.h
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/4.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VedioModel;

@interface MostNewAndHotCell : UITableViewCell

@property(nonatomic,strong)UIImageView *titleImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *subImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIImageView *vedioImage;
@property(nonatomic,strong)UILabel *vedioNumber;
@property(nonatomic,strong)UIButton *btn;

@property(nonatomic,strong)VedioModel *vedioModel;

@end
