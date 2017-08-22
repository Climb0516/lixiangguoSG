//
//  ChongZhiViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/18.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ChongZhiViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DayTaskViewController.h"
#import "TiXianViewController.h"
#import "MineTeamController.h"
@interface ChongZhiViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)NSString *number;
@property(nonatomic,strong)NSString *payType;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSString *iss;
@end

@implementation ChongZhiViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.otherNumber  setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    self.otherNumber.delegate = self;
        self.scrollerView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.accountLabel.text =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Account"];
    self.iss = @"99999";
}
- (IBAction)backUpchontroller:(UIButton *)sender {
    [self backController];
}
- (IBAction)teamAction:(UIButton *)sender {
    MineTeamController *mineTeam = [[MineTeamController alloc]init];
    [self.navigationController pushViewController:mineTeam animated:YES];
}
- (IBAction)shouyiAction:(UIButton *)sender {
    DayTaskViewController *dayTask = [[DayTaskViewController alloc]init];
    [self.navigationController pushViewController:dayTask animated:YES];
}
- (IBAction)zhangdanAction:(UIButton *)sender {
}
- (IBAction)tixianAction:(UIButton *)sender {
    TiXianViewController *tixian = [[TiXianViewController alloc]init];
    [self.navigationController pushViewController:tixian animated:YES];
}

- (IBAction)weixinpayBtn:(UIButton *)sender {

    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"此方式尚未开通!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
      [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (IBAction)oneBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    sender.titleLabel.numberOfLines = 0;
     sender.highlighted = NO;
    self.iss = @"999";
    self.secondBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
    self.number = @"6";
}
- (IBAction)towBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
     self.number = @"30";
     self.iss = @"999";
}

- (IBAction)thereBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
     self.number = @"60";
     self.iss = @"999";
}

- (IBAction)fourBtn:(UIButton *)sender {
     sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
     self.number = @"100";
     self.iss = @"999";
}

- (IBAction)fiveBtn:(UIButton *)sender {
     sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
     self.number = @"520";
     self.iss = @"999";
}

- (IBAction)sixBtn:(UIButton *)sender {
     sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
     self.iss = @"999";
     self.number = @"1200";
}

- (IBAction)sevenBtn:(UIButton *)sender {
     sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.eightBtn.selected = NO;
     self.iss = @"999";
     self.number = @"4888";
}
- (IBAction)enghtBtn:(UIButton *)sender {
     sender.selected = !sender.selected;
    self.shiBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.iss = @"999";
     self.number = @"360";
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    self.shiBtn.selected = NO;
    self.secondBtn.selected = NO;
    self.thereBtn.selected = NO;
    self.fourBtn.selected = NO;
    self.fiveBtn.selected = NO;
    self.sixBtn.selected = NO;
    self.sevenBtn.selected = NO;
    self.eightBtn.selected = NO;
    self.number = @"0";
    return YES;
    
}





- (IBAction)buyBtn:(UIButton *)sender {

    if ([self.iss isEqualToString:@"99999"] ) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择充值数量" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];

        [alertVC addAction:confirm];

        [self presentViewController:alertVC animated:YES completion:nil];
        return;
    }
    
    
    
        NSString *appID = @"2016090601855074";
        //商户id
        NSString *pid = @"2088421412459044";
        //私钥
        NSString *rsa2PrivateKey = @"";
        NSString *rsaPrivateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBALUGrjfcfTEO1pECJe5HG7Q8X6hNorPHDYIUBaVyUSQrNwUY0DlqcISrikIfF2qQrtfkykcAVR1LP000vcThvc0oa553lbO4tAZxcvrEE1bujm4wHU++wkD128McEbDVYOVwS078/dlBzeBlfch4KeJxbgqYpPy7RE0SsYYRe4ARAgMBAAECgYAoRdg0bUUcyORLVmMB46fyLQxK8RqlTD9hFPs8l3Ydyc9vvtl0LI3jthYIJ8qZ1p5PQYMO0LAe2EK49mbRijcjMXTUEoVYcxCK2ncHb62v+ymOgbx287KqBOiZPr6NFShuoCt4qdUaArwyl8F/hohOEu6J/0ksr/9yjXFuFTlgwQJBANlGAAXNkZCN53pf/o5w5wWtCV2MV4ECNN2EcnYK6qSZxvv4ZfbtQaeiC6+PyXwsaE7rLPyt20Gyadzq4KM2N+0CQQDVSr7VWPjsOPrh+J1G5GRgY+2UN5740rL6BkxgN97G+uJ29LaAzSvMEXha1estk+fsNc20Wc8SHS93ualRNBw1AkEAt9eYG1Dmk1bO/2gMP0Be6hmQ7BvcyqcwTiNMqn7wLdiEWx3CQR5dyFa/5owWoz/7/pLVnPQKqtso4inHa7JrvQJAIkUqOFldVYcqOFib3KIhxqMHr0Lolg40l5ufde5EKzBwZrCXCkbs/JLqBZ5NdTtIjlluvcWYUc7Cq7f3DocS6QJAXRBKg8Za4lVEw8ZOcogPzqxjH2PxXBbTaOrG8na54uPA8Emn8NJI9nQ2OliR4DPPyFjyxzaZodZA/M2ztJdtIA==";
  
        //生成订单信息及签名
        //将商品信息赋予AlixPayOrder的成员变量
        Order* order = [Order new];
        // NOTE: app_id设置
        order.app_id = appID;
        
        // NOTE: 支付接口名称
        order.method = @"alipay.trade.app.pay";
        // NOTE: 参数编码格式
        order.charset = @"utf-8";
        
        // NOTE: 当前时间点
        NSDateFormatter* formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        order.timestamp = [formatter stringFromDate:[NSDate date]];
        // NOTE: 支付版本
        order.version = @"1.0";
        // NOTE: sign_type设置
//        order.sign_type = @"RSA";
        // NOTE: 商品数据
        order.biz_content = [BizContent new];
        order.biz_content.body = @"我是测试数据";
        order.biz_content.subject = @"理想产品订单";  // 商品说明
        order.notify_url = @"http://121.40.99.168.8003/return_url.aspx";
        order.biz_content.out_trade_no = [self getRandNo]; //订单ID（由商家自行制定）
        order.biz_content.timeout_express = @"30m"; //超时时间设置
        if ([self.number isEqualToString:@"0"]) {
            order.biz_content.total_amount = self.otherNumber.text; //商品价格
        }else{
    
  order.biz_content.total_amount = self.number; //商品价格
        }
        //将商品信息拼接成字符串
        NSString *orderInfo = [order orderInfoEncoded:NO];
        NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
        NSLog(@"orderSpec = %@",orderInfo);
        
        // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防 止公私钥数据泄露；
        //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
        NSString *signedString = nil;
        RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
        if ((rsa2PrivateKey.length > 1)) {
            signedString = [signer signString:orderInfo withRSA2:YES];
        } else {
            signedString = [signer signString:orderInfo withRSA2:NO];
        }
        
        // NOTE: 如果加签成功，则继续执行支付
        if (signedString != nil) {
            //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
            NSString *appScheme = @"alisdkdemoshare";
            
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                     orderInfoEncoded, signedString];
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSLog(@"reslut = %@",resultDic);
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
                    NSString *mobile = [user objectForKey:@"userID"];
                    ManagerType
                    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                    [dic setValue:mobile forKey:@"MemberId"];
                    [dic setValue:@"1" forKey:@"Amount"];// 总数量
                    [dic setValue:@"1" forKey:@"DeliveryType"];// 配送方式
                    [dic setValue:@"0" forKey:@"AddressId"];// 收货地址
                    [dic setValue:@"1" forKey:@"PayType"];// 配送方式
                    [dic setValue:@"1" forKey:@"State"];// 状态
                    if ([self.number isEqualToString:@"0"]) {
                       [dic setValue:self.otherNumber.text forKey:@"TotalPrice"];//总价
                    }else{
                       [dic setValue:self.number forKey:@"TotalPrice"];//总价
                    }
                    [dic setValue:@"0" forKey:@"TransCost"]; //运费
                    [dic setValue:@"0" forKey:@"ProductId"];
                    [dic setValue:self.number forKey:@"CornId"];
                    [dic setValue:@"0" forKey:@"GiftId"];
                    [dic setValue:@"0" forKey:@"ActivityId"];
                    NSString *httpUrl = [UrlString stringByAppendingString:@"/OrdersInterface/PostHandler.ashx"];
                    [self.manager POST:httpUrl parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
                        NSLog(@"%@",responseObject);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    }];
                }
            }];
        }
        return;
}

//这个方法用来获取随机的一个商家的ID字符串.
-(NSString *)getRandNo{
    //每一个订单编号由15个字符组成
    static int numberKey = 15;
    NSMutableString *str = [NSMutableString string];
    NSString *resuStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    //初始化随机函数,以当前时间为种子
    srand(time(0));
    for (int i = 0; i < numberKey; i++) {
        unsigned index = rand() % [resuStr length];
        //随机截取一个字符拼接到最终结果上
        [str appendString:[resuStr substringWithRange:NSMakeRange(index, 1)]];
    }
    return str;
}

-(void)backController{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
