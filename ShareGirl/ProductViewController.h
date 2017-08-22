//
//  ProductViewController.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/24.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSString *vedioURL;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSString *proimageUrl;
@property(nonatomic,strong)NSString *proName;
@property(nonatomic,strong)NSString *proPrice;
@property(nonatomic,strong)NSString *proContent;
@property(nonatomic,strong)NSString *proID;

@end
