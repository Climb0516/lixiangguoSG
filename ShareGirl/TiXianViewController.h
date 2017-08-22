//
//  TiXianViewController.h
//  Utopia
//
//  Created by 姜鸥人 on 16/9/8.
//  Copyright © 2016年 HeiCoder_OR. All rights reserved.
//
//提现申请

#import <UIKit/UIKit.h>

@interface TiXianViewController : UIViewController
// 名字
@property (strong, nonatomic) IBOutlet UITextField *Name;
// 卡号
@property (strong, nonatomic) IBOutlet UITextField *CarNumber;
@property (strong, nonatomic) IBOutlet UITextField *bankName;
// 省
@property (strong, nonatomic) IBOutlet UITextField *sheng;
//市
@property (strong, nonatomic) IBOutlet UITextField *shi;
//区/县
@property (strong, nonatomic) IBOutlet UITextField *xian;
// 详细银行
@property (strong, nonatomic) IBOutlet UITextField *xiangxi;
//金额
@property (strong, nonatomic) IBOutlet UITextField *moneyNumber;
//密码
@property (strong, nonatomic) IBOutlet UITextField *passWord;












@end
