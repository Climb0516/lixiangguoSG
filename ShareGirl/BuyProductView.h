//
//  BuyProductView.h
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/26.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyProductView : UIView
@property (strong, nonatomic) IBOutlet UIButton *quxiaoBtnAction;
@property (strong, nonatomic) IBOutlet UIButton *quedingBtnAction;

@property (strong, nonatomic) IBOutlet UIImageView *proImage;
@property (strong, nonatomic) IBOutlet UILabel *proName;
@property (strong, nonatomic) IBOutlet UILabel *proPrice;

@property (strong, nonatomic) IBOutlet UILabel *proContent;

@property (strong, nonatomic) IBOutlet UIButton *jianhaoBtnAction;
@property (strong, nonatomic) IBOutlet UIButton *jiahaoBtnAction;

@property (strong, nonatomic) IBOutlet UILabel *proNumber;


@end
