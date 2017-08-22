//
//  DarenfourCell.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DarenfourCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UICollectionView *mingDreamShopCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *mineDreanFlow;
@property (strong, nonatomic) IBOutlet UIButton *addMineDreamButton;
@property(nonatomic,strong)NSArray *imageArray;
@end
