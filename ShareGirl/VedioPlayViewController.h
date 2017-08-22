//
//  VedioPlayViewController.h
//  V-show
//
//  Created by 姜鸥人 on 2017/7/12.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VedioPlayHeaderView.h"
@interface VedioPlayViewController : UIViewController

@property(nonatomic,strong)UICollectionView *vedioCollect;
@property(nonatomic,strong)NSString *vedioURL;
@property(nonatomic,strong)NSString *modelID;
@property(nonatomic,strong)NSString *userimage;
@property(nonatomic,strong)NSString *modelName;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)VedioPlayHeaderView *vedioHeaderView;
@end
