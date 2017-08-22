//
//  RegistraViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/15.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "RegistraViewController.h"

@interface RegistraViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableDictionary *dic;
@end

@implementation RegistraViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
   [self.phoneNumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
     [self.yaoqingNumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passWord setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.surePassword setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
}
- (IBAction)backView:(id)sender {
      [self dismissViewControllerAnimated:NO completion:nil];
}
- (IBAction)registrBtn:(id)sender {
    
    if ([self.phoneNumber.text isEqualToString:@""]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示!" message:@"请输入准确信息!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else if (self.passWord.text != self.surePassword.text) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示!" message:@"密码不匹配!!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        ManagerType
            self.dic  = [NSMutableDictionary dictionary];
             self.dic[@"Mobile"] =self.phoneNumber.text;
            self.dic[@"SuperMobile"] = self.yaoqingNumber.text;
            self.dic [@"LoginPwd"] = self.passWord.text;
            NSString*httpUrl = [UrlString stringByAppendingString:@"/MemberInterface/PostHandler.ashx"];
        [self.manager POST:httpUrl parameters:self.dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject[@"Result"]);
            NSString *strr = [NSString stringWithFormat:@"%@",responseObject[@"Message"]];
            if ([strr  isEqual: @"1"]) {
                UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"恭喜您,注册成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:a repeats:YES];
                [a show];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else{
                UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"注册失败,请重新注册!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
                [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:a repeats:YES];
                [a show];
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
          [self dismissViewControllerAnimated:NO completion:nil];
    }
}
//回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
@end
