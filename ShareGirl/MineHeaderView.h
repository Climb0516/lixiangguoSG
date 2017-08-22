//
//  MineHeaderView.h
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/4.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subView.h"
@interface MineHeaderView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)UIButton *joinUpVip;
@property(nonatomic,strong)UILabel *userName;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UIButton *btn6;

@property(nonatomic,strong)subView *view1;
@property(nonatomic,strong)subView *view2;

@property(nonatomic,strong)UICollectionView *collevtiovView;

@property(nonatomic,strong)NSMutableArray *MineGirlArray;


@end
