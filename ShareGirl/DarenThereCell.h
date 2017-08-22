//
//  DarenThereCell.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DarenThereCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *mineVedioCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *mineVidioFlow;
@property (strong, nonatomic) IBOutlet UIButton *addMineVedioButton;
@property(nonatomic,strong)NSArray *imageArray;
@end
