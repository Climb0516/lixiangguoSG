//
//  SignInViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/15.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "SignInViewController.h"
#import "RegistraViewController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface SignInViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)AFHTTPSessionManager  *manager;
@property(nonatomic,strong)NSString *account;
@property(nonatomic,strong)NSString *password;

@end

@implementation SignInViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    [self.signTexeFiled  setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.PassWordTextFiled  setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

}
- (IBAction)backUpController:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBgColor" object:nil userInfo:nil];

}
- (IBAction)weixinSign:(UIButton *)sender {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession currentViewController:nil completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            UMSocialUserInfoResponse *resp = result;
            
            // 授权信息
            NSLog(@"Wechat uid: %@", resp.uid);
            NSLog(@"Wechat openid: %@", resp.openid); //账号
            NSLog(@"Wechat unionid: %@", resp.unionId); // 密码
            self.password = resp.unionId;
            self.account = resp.openid;
            
            NSLog(@"Wechat accessToken: %@", resp.accessToken);
            NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
            NSLog(@"Wechat expiration: %@", resp.expiration);
            // 用户信息
            NSLog(@"Wechat name: %@", resp.name); // 姓名
            NSLog(@"Wechat iconurl: %@", resp.iconurl); // 头像
            NSLog(@"Wechat gender: %@", resp.unionGender); // 男女
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:resp.iconurl forKey:@"weixintouxiang"];
            [user setObject:resp.name forKey:@"weixinmingzi"];
            [user setObject:resp.openid forKey:@"weixinzhanghao"];
            // 第三方平台SDK源数据
            NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    ManagerType
    dic[@"Mobile"] =self.account;
    dic[@"LoginPwd"] = self.password;
    NSString*httpUrl  = [UrlString stringByAppendingString:@"/MemberInterface/GetHandler.ashx"];
    
    [self.manager POST:httpUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSString *strr = [NSString stringWithFormat:@"%@",responseObject[@"Result"]];
        if ([strr  isEqual: @"0"]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录账号或密码错误!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVC addAction:confirm];
            [self presentViewController:alertVC animated:YES completion:nil];
            return ;
        }else{
            NSArray *array = responseObject[@"Data"];
            NSDictionary *dic = array[0];
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:dic[@"Mobile"] forKey:@"Mobile"];
            [user setObject:dic[@"ID"] forKey:@"userID"];
            [user setObject:dic[@"LoginName"] forKey:@"userName"];
            [user setObject:dic[@"Grade"] forKey:@"userGrade"];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];        
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isweixin"];
        }
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"登陆成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:a repeats:YES];
        [a show];
        [self dismissViewControllerAnimated:NO completion:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBgColor" object:nil userInfo:nil];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];    
    
}
- (IBAction)qqSign:(UIButton *)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"改功能暂未开放!" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (IBAction)weiboSign:(id)sender {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"改功能暂未开放!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (IBAction)dengluBtn:(id)sender {
    if ([self.signTexeFiled.text isEqualToString:@""]) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的手机号!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
     if([self.PassWordTextFiled.text isEqualToString:@""]){
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的密码!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
         return;
    }
      NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    ManagerType
        dic[@"Mobile"] =self.signTexeFiled.text;
        dic[@"LoginPwd"] = self.PassWordTextFiled.text;
    NSString*httpUrl  = [UrlString stringByAppendingString:@"/MemberInterface/GetHandler.ashx"];

        [self.manager POST:httpUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"%@",responseObject);
            NSString *strr = [NSString stringWithFormat:@"%@",responseObject[@"Result"]];
            if ([strr  isEqual: @"0"]) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录账号或密码错误!" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertVC addAction:confirm];
                [self presentViewController:alertVC animated:YES completion:nil];
                return ;
            }else{
                NSArray *array = responseObject[@"Data"];
                NSLog(@"%@",array);
                NSDictionary *dic = array[0];
                // 新的方法
                NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                [user setObject:dic[@"Account"] forKey:@"Account"];
                [user setObject:dic[@"Mobile"] forKey:@"Mobile"];
                [user setObject:dic[@"LoginName"] forKey:@"userName"];
                [user setObject:dic[@"Grade"] forKey:@"userGrade"];
                 [user setObject:dic[@"ID"] forKey:@"userID"];
                
                NSLog(@"%@",user);
                
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLogin"];
            }
            UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示!" message:@"登陆成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
            [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:) userInfo:a repeats:YES];
            [a show];
            [self dismissViewControllerAnimated:NO completion:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBgColor" object:nil userInfo:nil];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
}

- (IBAction)zhuceBtn:(id)sender {
    RegistraViewController *zhuce = [[RegistraViewController alloc]init];
    [self presentViewController:zhuce animated:NO completion:nil];
}
- (void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
//回收键盘
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
