//
//  ChongZhiViewController.h
//  V-show
//
//  Created by 姜鸥人 on 2017/7/18.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChongZhiViewController : UIViewController

@property(nonatomic,strong)NSString *username;
@property(nonatomic,strong)UIImageView *userImage;


@property (strong, nonatomic) IBOutlet UIScrollView *scrollerView;


@property (strong, nonatomic) IBOutlet UIButton *shiBtn;
@property (strong, nonatomic) IBOutlet UIButton *secondBtn;
@property (strong, nonatomic) IBOutlet UIButton *thereBtn;

@property (strong, nonatomic) IBOutlet UIButton *fourBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;

@property (strong, nonatomic) IBOutlet UIButton *sixBtn;

@property (strong, nonatomic) IBOutlet UIButton *sevenBtn;

@property (strong, nonatomic) IBOutlet UIButton *eightBtn;

@property (strong, nonatomic) IBOutlet UITextField *otherNumber;


@property (strong, nonatomic) IBOutlet UIButton *buyBtn;


@property (strong, nonatomic) IBOutlet UILabel *accountLabel;




@end
