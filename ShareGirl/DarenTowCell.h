//
//  DarenTowCell.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DarenTowCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UICollectionView *picCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *picFlow;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIButton *addMinePicButton;
@property(nonatomic,strong)NSArray *imageArray;



@end
