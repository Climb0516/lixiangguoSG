//
//  AddressViewController.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/27.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *addName;
@property (strong, nonatomic) IBOutlet UITextField *addPhone;
@property (strong, nonatomic) IBOutlet UILabel *addressOne;
@property (strong, nonatomic) IBOutlet UIButton *addChose;
@property (strong, nonatomic) IBOutlet UITextField *addContent;
@property (strong, nonatomic) IBOutlet UIButton *addDefault;


@property(nonatomic,strong)NSString *provinceName;
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *townName;


@end
