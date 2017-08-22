//
//  VedioPlayHeaderView.h
//  V-show
//
//  Created by 姜鸥人 on 2017/7/22.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreVeidoCell.h"
#import "ProduceModel.h"
#import "HomeCell.h"
#import "VedioModel.h"
@protocol VedioPlayHeaderViewDelegate <NSObject>

- (void)pushProductViewController:(NSIndexPath *)indexPath;
- (void)pushPicDateViewController;
- (void)pushVedioPlayViewController:(NSIndexPath *)indexPath;

@end


@interface VedioPlayHeaderView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) id<VedioPlayHeaderViewDelegate>delegate;
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)UIButton  *dateBtn;// 约会
@property(nonatomic,strong)UIButton *concernBtn; // 关注
@property(nonatomic,strong)UILabel *concernNumber;// 关注数量
@property(nonatomic,strong)UICollectionView *imageCollect;// 图片轮播
@property(nonatomic,strong)UICollectionView *otherCollect;//产品梦想活动

@property(nonatomic,strong)UICollectionView *VoedioCollect;

@property(nonatomic,strong)NSMutableArray *imageArray; // 图片数组
@property(nonatomic,strong)NSMutableArray *proDuctArray;  // 产品数组

@property(nonatomic,strong)NSMutableArray *vedioArray;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *yuewoBtn;
@property(nonatomic,strong)UIButton *vedioBtn;


@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UIButton *btn5;
@property(nonatomic,strong)UIButton *btn6;




@end
