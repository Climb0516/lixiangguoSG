//
//  ClassHeaderView.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/21.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ClassHeaderView.h"
#import "ClassCollectionCell.h"
#import "MineGirlModel.h"
#import "MoreVeidoCell.h"
#import "ProduceModel.h"
@implementation ClassHeaderView

static NSString *VedioCell_id = @"VedioCell_id";
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.banderView = [[UIView alloc]init];
    [self addSubview:self.banderView];
    [self.banderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self);
        make.height.mas_equalTo(150);
        make.top.equalTo(self).offset(20);
    }];
    
    UIImageView *image = [[UIImageView alloc]init];
    image.image = [UIImage imageNamed:@"Image"];
    [self.banderView addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.banderView);
    }];
    
    self.banderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.banderBtn setImage:[UIImage imageNamed:@"b-phone"] forState:UIControlStateNormal];
    [self.banderView addSubview:self.banderBtn];
    [self.banderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.banderView);
    }];
    
    UIImageView *imageTitle = [[UIImageView alloc]init];
    imageTitle.image = [UIImage imageNamed:@"ni"];
    [self.banderView addSubview:imageTitle];
    [imageTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.banderBtn.mas_centerX);
        make.top.equalTo(self.banderBtn.mas_bottom).offset(10);
    }];
    
    self.banderLabel = [[UILabel alloc]init];
    self.banderLabel.text = @"8360人在玩";
    self.banderLabel.font = [UIFont systemFontOfSize:10];
    self.banderLabel.textColor = [UIColor whiteColor];
    [self.banderView addSubview:self.banderLabel];
    [self.banderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(imageTitle.mas_bottom);
        make.right.equalTo(self.banderView).offset(-15);
    }];
    
    UIImageView *imageOne = [[UIImageView alloc]init];
    imageOne.image = [UIImage imageNamed:@"dian"];
    [self addSubview:imageOne];
    [imageOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self.banderView.mas_bottom).offset(8);
    }];
    UILabel *shopLabel = [[UILabel alloc]init];
    shopLabel.text = @"理想商城";
    shopLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:shopLabel];
    [shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageOne.mas_centerY);
        make.left.equalTo(imageOne.mas_right).offset(5);
    }];
    
    //产品
    UICollectionViewFlowLayout *flowlayout1 =[[UICollectionViewFlowLayout alloc]init];
    flowlayout1.minimumLineSpacing = 5;
    // 每个item 的大小
    flowlayout1.itemSize = CGSizeMake((SCREEN_WIDTH-10)/3, (SCREEN_WIDTH-10)/3);
    flowlayout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout1.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    self.proDuctCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout1];
    [self addSubview:self.proDuctCollectionView];
    [self.proDuctCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(imageOne.mas_bottom).offset(8);
        make.height.mas_equalTo((SCREEN_WIDTH-10)/3);
    }];
    //注册重用标志
    [self.proDuctCollectionView registerClass:[MoreVeidoCell class] forCellWithReuseIdentifier:VedioCell_id];
    //设置collectionView的代理
    self.proDuctCollectionView.delegate = self;
    self.proDuctCollectionView.dataSource = self;
    self.proDuctCollectionView.tag = 10092;
    self.proDuctCollectionView.backgroundColor = [UIColor whiteColor];
    self.proDuctCollectionView.showsVerticalScrollIndicator = NO;
    self.proDuctCollectionView.showsHorizontalScrollIndicator = NO;
    
    UIImageView *imageTow = [[UIImageView alloc]init];
    imageTow.image = [UIImage imageNamed:@"fujin"];
    [self addSubview:imageTow];
    [imageTow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self.proDuctCollectionView.mas_bottom).offset(8);
    }];
    UILabel *DarenLabel = [[UILabel alloc]init];
    DarenLabel.text = @"附近达人";
    DarenLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:DarenLabel];
    [DarenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageTow.mas_centerY);
        make.left.equalTo(imageTow.mas_right).offset(5);
    }];
    
    //达人
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.minimumLineSpacing = 5;
    // 每个item 的大小
    flowlayout.itemSize = CGSizeMake((SCREEN_WIDTH-20)/2, 110);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    self.collevtiovView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    [self addSubview:self.collevtiovView];
    [self.collevtiovView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(imageTow.mas_bottom).offset(8);
        make.height.mas_equalTo(110);
    }];
    [self.collevtiovView registerClass:[MoreVeidoCell class] forCellWithReuseIdentifier:VedioCell_id];
    //设置collectionView的代理
    self.collevtiovView.dataSource = self;
    self.collevtiovView.delegate = self;
    self.collevtiovView.tag = 10091;
    //指示条
    self.collevtiovView.showsVerticalScrollIndicator = NO;
    self.collevtiovView.showsHorizontalScrollIndicator = NO;
    self.collevtiovView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageThere = [[UIImageView alloc]init];
    imageThere.image = [UIImage imageNamed:@"lixiangdaren"];
    [self addSubview:imageThere];
    [imageThere mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.equalTo(self.collevtiovView.mas_bottom).offset(8);
    }];
    UILabel *DreamLabel = [[UILabel alloc]init];
    DreamLabel.text = @"理想达人";
    DreamLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:DreamLabel];
    [DreamLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(imageThere.mas_centerY);
        make.left.equalTo(imageThere.mas_right).offset(5);
    }];
    
    
}


//设置分区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 10091) {
      return self.modelArray.count;
    }
    if (collectionView.tag == 10092) {
        return self.proDuctArray.count;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 10091) {
        MineGirlModel *model = self.modelArray[indexPath.row];
        
  MoreVeidoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VedioCell_id forIndexPath:indexPath];
                NSLog(@"%@",model.ImageUrl);
        NSString *string = [[NSString stringWithString:model.ImageUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:string]];
        return cell;
    }
    if (collectionView.tag == 10092) {
        MoreVeidoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VedioCell_id forIndexPath:indexPath];
        ProduceModel *model = self.proDuctArray[indexPath.row];
        NSString *string = [[NSString stringWithString:model.SmallImageUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"%@",model.SmallImageUrl);
        [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:string]];
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 10092) {
        [self.delegate pushProDuctControllerView:indexPath];
    }else if (collectionView.tag == 10091){
    [self.delegate push:indexPath];
}
    
    
}


@end
