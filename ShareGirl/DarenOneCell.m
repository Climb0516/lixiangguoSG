//
//  DarenOneCell.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "DarenOneCell.h"
#import "MineGirlTypeCell.h"
@implementation DarenOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.JinengCollectionView registerNib:[UINib nibWithNibName:@"MineGirlTypeCell" bundle:nil] forCellWithReuseIdentifier:@"MineGirlTypeCell"];
    self.JinengCollectionView.dataSource = self;
    self.JinengCollectionView.delegate = self;
    self.JinengCollectionView.showsHorizontalScrollIndicator = NO;
    self.JinengFlow.itemSize = CGSizeMake(70, 35);
    self.JinengFlow.sectionInset =  UIEdgeInsetsMake(10, 10, 10, 10);
    self.JinengFlow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.titleArray = @[@"心理咨询",@"陪你聊天",@"约戏",@"广告",@"逛街",@"约饭",@"录制",@"逛街",@"约饭",@"录制"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titleArray.count;
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MineGirlTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineGirlTypeCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UINib nibWithNibName:@"MineGirlTypeCell" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    }
    [cell.typeBtn setTitle:self.titleArray[indexPath.row] forState:UIControlStateNormal];
    [cell.typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}
-(void)typeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
