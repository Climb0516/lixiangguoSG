//
//  ClassHeaderView.h
//  V-show
//
//  Created by 姜鸥人 on 2017/7/21.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassHeaderViewDelegate <NSObject>

- (void)push:(NSIndexPath *)indexPath;
- (void)pushProDuctControllerView:(NSIndexPath *)indenPath;

@end

@interface ClassHeaderView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIView *banderView;

@property(nonatomic,strong)UIButton *banderBtn;
@property(nonatomic,strong)UILabel *banderLabel;

@property(nonatomic,strong)UICollectionView *collevtiovView;
@property(nonatomic,strong)UICollectionView *proDuctCollectionView;
@property(nonatomic,strong)NSMutableArray *proDuctArray;
@property(nonatomic,strong)NSMutableArray *modelArray;

@property (nonatomic, weak) id<ClassHeaderViewDelegate>delegate;


@end
