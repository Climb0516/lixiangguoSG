//
//  DarenThereCell.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "DarenThereCell.h"
#import "MineGuanZhuCell.h"

@implementation DarenThereCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.mineVedioCollectionView registerNib:[UINib nibWithNibName:@"MineGuanZhuCell" bundle:nil] forCellWithReuseIdentifier:@"MineGuanZhuCell"];;
    self.mineVedioCollectionView.dataSource = self;
    self.mineVedioCollectionView.delegate = self;
    self.mineVedioCollectionView.showsHorizontalScrollIndicator = NO;
    self.mineVidioFlow.itemSize = CGSizeMake(130, 90);
    self.mineVidioFlow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.imageArray = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"],[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MineGuanZhuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MineGuanZhuCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UINib nibWithNibName:@"MineGirlTypeCell" bundle:nil] instantiateWithOwner:self options:nil].firstObject;
    }
    cell.guanzuhCell.image = self.imageArray[indexPath.row];
    return cell;
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
