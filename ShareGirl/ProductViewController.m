//
//  ProductViewController.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/7/24.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ProductViewController.h"
#import "ProViewCell.h"
#import "BuyProductView.h"
#import "AddressViewController.h"
#import "ZGLVideoPlyer.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>

@interface ProductViewController ()
@property(nonatomic,strong)ZGLVideoPlyer *player;
@property(nonatomic,strong)UIButton *buyBtn;
@property(nonatomic,strong)BuyProductView *buyproView;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)UIButton *backBtnAction;
@property(nonatomic,strong)NSMutableArray *imageArray;
@end


@implementation ProductViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];    
    self.navigationItem.title = @"产品";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH/1.783 , SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/1.783-50) style:UITableViewStylePlain];
    self.tableView.delegate= self;
    self.tableView.dataSource =self;
    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.783)];
    self.player.videoMaskView.fullScreenBtn.hidden = YES;
    self.player.videoUrlStr = self.vedioURL;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti1) name:@"noti1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti2) name:@"noti2" object:nil];
    [self.view addSubview:self.player];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    self.buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buyBtn setImage:[UIImage imageNamed:@"buy>"] forState:UIControlStateNormal];
    self.buyBtn.frame = CGRectMake(0,  SCREEN_HEIGHT-50, SCREEN_WIDTH,50);
    [self.buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buyBtn];
    
    self.buyproView =  [[[NSBundle mainBundle] loadNibNamed:@"BuyProductView" owner:self options:nil] objectAtIndex:0];
    [self.buyproView.quxiaoBtnAction addTarget:self action:@selector(quxiaoBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.buyproView.proImage sd_setImageWithURL:[NSURL URLWithString:[self.proimageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    self.buyproView.proName.text = self.proName;
    self.buyproView.proContent.text = self.proContent;
    self.buyproView.proPrice.text = [NSString stringWithFormat:@"¥ %@",self.proPrice];
      [self.buyproView.quedingBtnAction addTarget:self action:@selector(quedingBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIWindow *windeo =  [UIApplication sharedApplication].keyWindow;
    self.backBtnAction = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtnAction addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtnAction setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.backBtnAction.frame = CGRectMake(5, 12, 30, 30);
    [windeo addSubview:self.backBtnAction];
    [self getProDucetImageArray];
    
}
-(void)noti1{
    self.tableView.hidden = YES;
    self.buyBtn.hidden = YES;
          self.backBtnAction.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)noti2{
    self.tableView.hidden = NO;
    self.buyBtn.hidden = NO;
    self.backBtnAction.hidden = NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)getProDucetImageArray{
    ManagerType
    self.imageArray = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.proID forKey:@"ProductId"];
    [self.manager POST:[UrlString stringByAppendingString:@"/ProductDetailInterface/GetHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        for (NSDictionary *dic in responseObject[@"Data"]) {
            NSString *imgUrl  = dic[@"ImageUrl"];
            [self.imageArray addObject:imgUrl];
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.backBtnAction.hidden = YES;
    [self.player pause];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.backBtnAction.hidden = NO;
    [self.player play];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}
-(void)buyBtnAction{
    
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    if(isLogin){
        self.buyproView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.view addSubview:self.buyproView];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登陆账号!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
}];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}
-(void)quxiaoBtn{
    self.buyproView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
}
-(void)quedingBtn{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isAddress"];
    if(isLogin){
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

            order.biz_content.total_amount = self.proPrice; //商品价格

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
                    [dic setValue:self.proPrice forKey:@"TotalPrice"];//总价
     
                [dic setValue:@"0" forKey:@"TransCost"]; //运费
                [dic setValue:self.proID forKey:@"ProductId"];
                [dic setValue:@"0" forKey:@"CornId"];
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
    }else{
        AddressViewController *address = [[AddressViewController alloc]init];
        [self.navigationController pushViewController:address animated:YES];
    }
}
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
-(void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.imageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_idd = @"proView_id";
    ProViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_idd];
    if (!cell) {
        cell = [[ProViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_idd];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    [cell.proImage sd_setImageWithURL:[NSURL URLWithString:[self.imageArray[indexPath.row] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    view.frame  =  CGRectMake(0, 0, SCREEN_HEIGHT, 30);
    UILabel *title = [[UILabel alloc]init];
    title.text = @"产品详情";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
    }];
    
    
    UIView *subView1 = [[UIView alloc]init];
    subView1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [view addSubview:subView1];
    [subView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(5);
        make.right.equalTo(view).offset(-5);
        make.height.mas_equalTo(1);
        make.top.equalTo(view);
    }];

    
    
    UIView *subView = [[UIView alloc]init];
    subView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [view addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(5);
        make.right.equalTo(view).offset(-5);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(view);
    }];
    
    
    return view;
}
@end
