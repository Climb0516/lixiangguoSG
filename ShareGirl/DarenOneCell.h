//
//  DarenOneCell.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DarenOneCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UICollectionView *JinengCollectionView;
@property (strong, nonatomic) IBOutlet UICollectionViewFlowLayout *JinengFlow;
@property(nonatomic,strong)NSArray *titleArray;
@end
