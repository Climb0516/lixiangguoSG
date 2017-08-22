//
//  SignInViewController.h
//  V-show
//
//  Created by 姜鸥人 on 2017/7/15.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignInViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *signTexeFiled;
@property (strong, nonatomic) IBOutlet UITextField *PassWordTextFiled;
@property (strong, nonatomic) IBOutlet UIButton *forgetPassWord;
@property (strong, nonatomic) IBOutlet UIButton *signBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UIButton *WeChatBtn;
@property (strong, nonatomic) IBOutlet UIButton *qqBtn;
@property (strong, nonatomic) IBOutlet UIButton *weiboBtn;

@end
