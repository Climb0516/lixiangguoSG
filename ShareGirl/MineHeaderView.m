//
//  MineHeaderView.m
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/4.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "MineHeaderView.h"
#import "MineGuanZhuCell.h"
#import "VedioModel.h"  
@implementation MineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}
-(void)setupView{


    self.backBtn= [UIButton buttonWithType:UIButtonTypeSystem];
    [self.backBtn setImage:[UIImage imageNamed:@"back-1"] forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(25);
        make.left.equalTo(self).offset(5);
        make.width.height.mas_equalTo(30);
    }];
    UIImageView *backImage = [[UIImageView alloc]init];
    backImage.image = [UIImage imageNamed:@"kk"];
    [self addSubview:backImage];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(55);
    }];
    
    
    self.userImage = [[UIImageView alloc]init];
    self.userImage.image = [UIImage imageNamed:@"logo"];
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 25;
    [self addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(backImage.mas_centerY);
        make.left.equalTo(backImage.mas_left).offset(10);
        make.width.and.height.mas_equalTo(50);
    }];
    
    self.userName = [[UILabel alloc]init];
    self.userName.textColor = [UIColor blackColor];
    self.userName.text = @"时间有限";
    self.userName.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImage.mas_top).offset(5);
        make.left.equalTo(self.userImage.mas_right).offset(6);
    }];

    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.text = @"8654116";
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userName.mas_left);
        make.bottom.equalTo(self.userImage.mas_bottom).offset(-5);
    }];
    
    
    
//    
//    self.btn6 = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.btn6 setImage:[UIImage imageNamed:@"shopggg"] forState:UIControlStateNormal];
//    [self addSubview:self.btn6];
//    [self.btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.userImage.mas_centerY);
//        make.right.equalTo(self).offset(-15);
//    }];
//    

    self.btn4 = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.btn4 setImage:[UIImage imageNamed:@"bi"] forState:UIControlStateNormal];
    [self addSubview:self.btn4];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImage.mas_centerY);
        make.left.equalTo(backImage.mas_right).offset(30);
    }];
    
    
    self.joinUpVip = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.joinUpVip setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.joinUpVip setImage:[UIImage imageNamed:@"daren"] forState:UIControlStateNormal];
    [self addSubview:self.joinUpVip];
    [self.joinUpVip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.userImage.mas_centerY);
        make.right.equalTo(backImage.mas_right).offset(-15);
        
    }];
    
    
    UIView *grayView0 = [[UIView alloc]init];
    grayView0.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self addSubview:grayView0];
    [grayView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.userImage.mas_bottom).offset(10);
        make.height.mas_equalTo(5);
    }];
    
    
    UIView *viewOne = [[UIView alloc]init];
    viewOne.backgroundColor = [UIColor redColor];
    [self addSubview:viewOne];
    [viewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(grayView0.mas_bottom);
        make.height.mas_equalTo(110);
    }];
    //注册显示cell的类型
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.minimumLineSpacing = 5;
    // 每个item 的大小
    flowlayout.itemSize = CGSizeMake(SCREEN_WIDTH/2, 110);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    self.collevtiovView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    [self.collevtiovView registerNib:[UINib nibWithNibName:@"MineGuanZhuCell" bundle:nil] forCellWithReuseIdentifier:@"MineGuanZhuCell"];
    [viewOne addSubview:self.collevtiovView];
    [self.collevtiovView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(viewOne);
    }];
    //设置collectionView的代理
    self.collevtiovView.dataSource = self;
    self.collevtiovView.delegate = self;
    self.collevtiovView.tag = 10091;
    //指示条
    self.collevtiovView.showsVerticalScrollIndicator = NO;
    self.collevtiovView.showsHorizontalScrollIndicator = NO;
    self.collevtiovView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"聊天功能近期即将开放,敬请等待呦!";
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

//设置分区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.MineGirlArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VedioModel *model = self.MineGirlArray[indexPath.row];
    //1.2去重用池查找cell_id(cell 重用标志放到viewDidLoad方法里注册)
    MineGuanZhuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineGuanZhuCell" forIndexPath:indexPath];
    [cell.guanzuhCell sd_setImageWithURL:[NSURL URLWithString:[model.ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    cell.guazhuTitle.text = model.Title;

    return cell;
}



@end
