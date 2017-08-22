//
//  TiXianViewController.m
//  Utopia
//
//  Created by 姜鸥人 on 16/9/8.
//  Copyright © 2016年 HeiCoder_OR. All rights reserved.
//

#import "TiXianViewController.h"

@interface TiXianViewController ()
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation TiXianViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"提现申请";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(bcakView)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    
}
-(void)bcakView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//提交申请
- (IBAction)tijiaoshenqing:(id)sender {
    /*
    ManagerType
    NSString *string  = [NSString stringWithFormat:@"%@%@%@%@",self.sheng.text,self.shi.text,self.xian.text,self.xiangxi.text];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.Name.text forKey:@"AccountName"];
    [dic setValue:self.CarNumber.text forKey:@"BankCard"];
    [dic setValue:string forKey:@"BankName"];//银行名称
    [dic setValue:self.bankName.text forKey:@"Bank"];
    [dic setValue:UserID forKey:@"MemberId"];
    [dic setValue:@"0" forKey:@"State"];

     NSString *httpUrl = [UrlString stringByAppendingString:@"/CashInterface/PostHandler.ashx"];
     [self.manager.requestSerializer setValue:Token_id forHTTPHeaderField:@"Token"];
    [self.manager POST:httpUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([LXJF isEqual:@"0.00"]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您没有可提现的理想积分!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVC addAction:confirm];
            [self presentViewController:alertVC animated:YES completion:nil];
            return ;
        }
    NSString *strr = [NSString stringWithFormat:@"%@",responseObject[@"Result"]];
        NSString *stringMessage = [NSString stringWithFormat:@"%@",responseObject[@"Message"]];
        if ([strr  isEqual: @"0"]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:stringMessage preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVC addAction:confirm];
            [self presentViewController:alertVC animated:YES completion:nil];
            return ;
        }
        if([self.bankName.text rangeOfString:@"银行"].location !=NSNotFound){
        }else{
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"填写准确银行名称" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alertVC addAction:confirm];
            [self presentViewController:alertVC animated:YES completion:nil];
            return;
        }

        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"申请提现成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:)userInfo:a repeats:YES];
        [a show];
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    */
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"提示:" message:@"申请提现成功!" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerFireMethod:)userInfo:a repeats:YES];
    [a show];
    [self.navigationController popViewControllerAnimated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
