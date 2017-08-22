//
//  VedioPlayHeaderView.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/22.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "VedioPlayHeaderView.h"
#import "MoreVeidoCell.h"

@implementation VedioPlayHeaderView
static NSString *VedioCell_id = @"VedioCell_id";
static NSString *Cell_id = @"cell_id";
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)setupView{
        UIView *grayView = [[UIView alloc]init];
        grayView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    //    grayView.backgroundColor = [UIColor redColor];
        [self addSubview:grayView];
        [grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(3);
            make.width.equalTo(self);
            make.height.mas_equalTo(5);
        }];
    
    UIImageView *backView = [[UIImageView alloc]init];
    backView.image = [UIImage imageNamed:@"Vedio-kuang"];
    [self addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayView.mas_bottom);
        make.left.equalTo(self);

    }];

    self.userImage = [[UIImageView alloc]init];
//    self.userImage.image = [UIImage imageNamed:@"touxiang"];
    self.userImage.layer.masksToBounds = YES;
    self.userImage.layer.cornerRadius = 30;
    [self addSubview:self.userImage];
    [self.userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.top.equalTo(self).offset(30);
        make.width.height.mas_equalTo(60);
    }];
    
// 聊天按钮
    self.concernBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.concernBtn setBackgroundImage:[UIImage imageNamed:@"chat"] forState:UIControlStateNormal];
    [self addSubview:self.concernBtn];
    [self.concernBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userImage.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.userImage.mas_centerX);
    }];
    
// 
    UIView *veiw  =[[UIView alloc]init];
    [self addSubview:veiw];
    [veiw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView.mas_right);
        make.right.equalTo(self);
        make.top.equalTo(backView.mas_top);
        make.bottom.equalTo(backView.mas_bottom);
    }];

//    //注册显示cell的类型
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.minimumLineSpacing = 4;
    // 每个item 的大小
    flowlayout.itemSize = CGSizeMake(70, 110);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    self.imageCollect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
     [veiw addSubview:self.imageCollect];
    [self.imageCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(veiw);
        make.right.equalTo(veiw);
        make.top.equalTo(veiw);
        make.bottom.equalTo(veiw);
    }];
//    // 注册重用标志
    [self.imageCollect registerClass:[MoreVeidoCell class] forCellWithReuseIdentifier:VedioCell_id];
    //设置collectionView的代理
    self.imageCollect.delegate = self;
    self.imageCollect.dataSource = self;
    self.imageCollect.tag = 9900;
    //指示条
    self.imageCollect.showsVerticalScrollIndicator = NO;
    self.imageCollect.showsHorizontalScrollIndicator = NO;
    self.imageCollect.backgroundColor = [UIColor whiteColor];

    UIView *grayView3 = [[UIView alloc]init];
    grayView3.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    //    grayView.backgroundColor = [UIColor redColor];
    [self addSubview:grayView3];
    [grayView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom);
        make.width.equalTo(self);
        make.height.mas_equalTo(5);
    }];

    
     self.yuewoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.yuewoBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    self.yuewoBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.yuewoBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
    self.yuewoBtn.titleLabel.numberOfLines = 0;
    [self.yuewoBtn setBackgroundImage:[UIImage imageNamed:@"phoneblack"] forState:UIControlStateNormal];
    [self addSubview:self.yuewoBtn];
    [self.yuewoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayView3.mas_bottom).offset(5);
        make.right.equalTo(self);
    }];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    self.btn1.userInteractionEnabled = NO;
    self.btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn1 setTitle:@"心理咨询" forState:UIControlStateNormal];
    [self.btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn1];
    [self.btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yuewoBtn.mas_centerY);
        make.left.equalTo(grayView3).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    self.btn2.userInteractionEnabled = NO;
    self.btn2.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn2 setTitle:@"陪你聊天" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn2];
    [self.btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1);
        make.left.equalTo(self.btn1.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    self.btn3.userInteractionEnabled = NO;
    self.btn3.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn3 setTitle:@"运动健身" forState:UIControlStateNormal];
    [self.btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn3];
    [self.btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn2);
        make.left.equalTo(self.btn2.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    self.vedioBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.vedioBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
    self.vedioBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    self.vedioBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
    self.vedioBtn.titleLabel.numberOfLines = 0;
    [self.vedioBtn setBackgroundImage:[UIImage imageNamed:@"vedio-chat"] forState:UIControlStateNormal];
    [self addSubview:self.vedioBtn];
    [self.vedioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn1.mas_bottom).offset(10);
        make.left.equalTo(self);
    }];
    
    
    
    self.btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    self.btn4.userInteractionEnabled = NO;
    self.btn4.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn4 setTitle:@"心理咨询" forState:UIControlStateNormal];
    [self.btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn4];
    [self.btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.vedioBtn.mas_centerY);
        make.left.equalTo(self.vedioBtn.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    self.btn5 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn5 setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    self.btn5.userInteractionEnabled = NO;
    self.btn5.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn5 setTitle:@"摄影绘画" forState:UIControlStateNormal];
    [self.btn5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn5];
    [self.btn5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn4);
        make.left.equalTo(self.btn4.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    
    
    self.btn6 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn6 setBackgroundImage:[UIImage imageNamed:@"gray"] forState:UIControlStateNormal];
    self.btn6.userInteractionEnabled = NO;
    self.btn6.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.btn6 setTitle:@"摄影绘画" forState:UIControlStateNormal];
    [self.btn6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:self.btn6];
    [self.btn6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.btn5);
        make.left.equalTo(self.btn5.mas_right).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    

    UIView *grayView4 = [[UIView alloc]init];
    grayView4.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    //    grayView.backgroundColor = [UIColor redColor];
    [self addSubview:grayView4];
    [grayView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vedioBtn.mas_bottom).offset(10);
        make.width.equalTo(self);
        make.height.mas_equalTo(5);
    }];
    
    UIImageView *shukuang2 = [[UIImageView alloc]init];
    shukuang2.image = [UIImage imageNamed:@"video"];
    [self addSubview:shukuang2];
    [shukuang2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayView4.mas_bottom).offset(5);
        make.left.equalTo(self).offset(5);
    }];
    UILabel *shipin = [[UILabel alloc]init];
    shipin.text = @"往期视频";
    shipin.font = [UIFont systemFontOfSize:16];
    [self addSubview:shipin];
    [shipin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shukuang2.mas_centerY);
        make.left.equalTo(shukuang2.mas_right).offset(5);
    }];
    
    UIView *view3 = [[UIView alloc]init];
    [self addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(shipin.mas_bottom).offset(3);
        make.right.left.equalTo(self);
        make.height.mas_equalTo(250);
    }];
//    //注册显示cell的类型
    UICollectionViewFlowLayout *flowlayout3 =[[UICollectionViewFlowLayout alloc]init];
    flowlayout3.minimumLineSpacing = 4;
    // 每个item 的大小
    flowlayout3.itemSize =CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20)/2, 250);

    flowlayout3.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout3.sectionInset =  UIEdgeInsetsMake(5, 5, 5, 5);
    self.VoedioCollect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout3];
    [view3 addSubview:self.VoedioCollect];
    [self.VoedioCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view3);
        make.right.equalTo(view3);
        make.top.equalTo(view3);
        make.bottom.equalTo(view3);
    }];
    // 注册重用标志
    [self.VoedioCollect registerClass:[HomeCell class] forCellWithReuseIdentifier:Cell_id];
    //设置collectionView的代理
    self.VoedioCollect.delegate = self;
    self.VoedioCollect.dataSource = self;
    self.VoedioCollect.tag = 9903;
    self.otherCollect.backgroundColor = [UIColor redColor];
    self.VoedioCollect.showsVerticalScrollIndicator = NO;
    self.VoedioCollect.showsHorizontalScrollIndicator = NO;
    self.VoedioCollect.backgroundColor = [UIColor whiteColor];

    UIView *view2 = [[UIView alloc]init];
    [self addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view3.mas_bottom);
        make.right.left.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
    }];

    UIImageView *shukuang3 = [[UIImageView alloc]init];
    shukuang3.image = [UIImage imageNamed:@"dian"];
     [self addSubview:shukuang3];
    [shukuang3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view2.mas_top).offset(5);
        make.left.equalTo(self).offset(5);
    }];

    UILabel *mengxiang = [[UILabel alloc]init];
    mengxiang.text = @"我的创业项目";
    mengxiang.font = [UIFont systemFontOfSize:16];
    [view2 addSubview:mengxiang];
    [mengxiang mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(shukuang3.mas_centerY);
        make.left.equalTo(shukuang3.mas_right).offset(5);
    }];

  //注册显示cell的类型
    UICollectionViewFlowLayout *flowlayout1 =[[UICollectionViewFlowLayout alloc]init];
    flowlayout1.minimumLineSpacing = 5;
    // 每个item 的大小
    flowlayout1.itemSize = CGSizeMake((SCREEN_WIDTH-10)/3, (SCREEN_WIDTH-10)/3);
    flowlayout1.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowlayout1.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    self.otherCollect = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout1];
    [view2 addSubview:self.otherCollect];
    [self.otherCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2);
        make.right.equalTo(view2);
        make.top.equalTo(mengxiang.mas_bottom);
        make.bottom.equalTo(view2);
    }];
  //注册重用标志
    [self.otherCollect registerClass:[MoreVeidoCell class] forCellWithReuseIdentifier:VedioCell_id];
    //设置collectionView的代理
    self.otherCollect.delegate = self;
    self.otherCollect.dataSource = self;
    self.otherCollect.tag = 9901;
//    self.otherCollect.backgroundColor = [UIColor redColor];
    self.otherCollect.showsVerticalScrollIndicator = NO;
    self.otherCollect.showsHorizontalScrollIndicator = NO;
    self.otherCollect.backgroundColor = [UIColor clearColor];
    
    UIImageView *shukuang4 = [[UIImageView alloc]init];
    shukuang4.image = [UIImage imageNamed:@"darenshipin"];
    [view2 addSubview:shukuang4];
    [shukuang4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.otherCollect.mas_bottom).offset(5);
        make.left.equalTo(self).offset(5);
    }];
    
    UILabel *otherVedio = [[UILabel alloc]init];
    otherVedio.text = @"达人视频";
    otherVedio.font = [UIFont systemFontOfSize:16];
    [view2 addSubview:otherVedio];
    [otherVedio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(shukuang4.mas_centerY);
        make.left.equalTo(shukuang4.mas_right).offset(5);
    }];
    

}


//设置分区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag == 9900 ) {
        return self.imageArray.count;
    }
    if (collectionView.tag == 9901) {
         return self.proDuctArray.count;
    } 
    if (collectionView.tag == 9903) {
        return self.vedioArray.count;
        
    }
    return 0;
    
    
}

// 每个item的现实内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
        if (collectionView.tag == 9900) {
              MoreVeidoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VedioCell_id forIndexPath:indexPath];
            [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:[self.imageArray[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
            return cell;
    
        }
            if(collectionView.tag == 9901) {
                  MoreVeidoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VedioCell_id forIndexPath:indexPath];
            ProduceModel *model = self.proDuctArray[indexPath.row];
                NSString *string = [[NSString stringWithString:model.SmallImageUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSLog(@"%@",model.SmallImageUrl);
           [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:string]];

            return cell;
    }

    if (collectionView.tag == 9903) {
            HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:Cell_id forIndexPath:indexPath];
        if (self.vedioArray.count > 0) {
            VedioModel *model = self.vedioArray[indexPath.row];
            NSString *string = [[NSString stringWithString:model.ImageUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [cell.picImage sd_setImageWithURL:[NSURL URLWithString:string]];
            cell.userLabel.text = model.Title;
            [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[model.ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        }
        return cell;

    }
//
    return nil;

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 9900) {
    [self.delegate pushPicDateViewController];

        }
    if (collectionView.tag == 9901) {
     
         [self.delegate pushProductViewController:indexPath];
    }
     if (collectionView.tag == 9903) {
         [self.delegate pushVedioPlayViewController:indexPath];
    }
    
    
}

@end
