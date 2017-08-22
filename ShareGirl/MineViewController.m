//
//  MineViewController.m
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/4.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeaderView.h"
#import "DayTaskViewController.h"
#import "MostNewAndHotCell.h"
#import "VedioPlayViewController.h"
#import "LifeViewController.h"
#import "MineTeamController.h"
#import "shareViewController.h"
#import "SignInViewController.h"
#import "ShenQDRViewController.h"
#import "ChongZhiViewController.h"
#import "MineMessageCell.h"
@interface MineViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *ImageArray;

@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)MineHeaderView *mineHeaderView;
@property(nonatomic,strong)UIButton *vrBtn;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)UIButton *phoneBtn;
@property(nonatomic,strong)NSArray *userImage;
@property(nonatomic,strong)NSArray *userName;
@property(nonatomic,strong)NSArray *userTitle;
@end

@implementation MineViewController
static NSString *MineMessageCell_ID = @"MineMessageCell_id";
- (AFHTTPSessionManager *)manager{
   if (!_manager) {
      _manager = [AFHTTPSessionManager manager];
   }
   return _manager;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.vrBtn.hidden = NO;
   self.phoneBtn.hidden= NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self changeViewValue];

//
}
-(void)changeViewValue{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    if(isLogin){
//        if ([UserGender isEqual:@(1)]) {
//           self.mineHeaderView.image.image = [UIImage imageNamed:@"VIP"] ;
//        }else{
//            self.mineHeaderView.image.image= [UIImage imageNamed:@"VIP"] ;
//        }
        BOOL isWX =  [[NSUserDefaults standardUserDefaults] objectForKey:@"isweixin"];
        if (isWX) {
            NSString *string = [[NSUserDefaults standardUserDefaults]objectForKey:@"weixintouxiang"];
            [self.mineHeaderView.userImage sd_setImageWithURL:[NSURL URLWithString:string]];
            self.mineHeaderView.userName.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"weixinmingzi"];
//           self.mineHeaderView.titleLabel.text =[[NSUserDefaults standardUserDefaults]objectForKey:@"weixinzhanghao"];
        }else{
           
            self.mineHeaderView.userName.text = @"时间有限";
           self.mineHeaderView.titleLabel.text =  [[NSUserDefaults standardUserDefaults]objectForKey:@"Mobile"];
            
            self.mineHeaderView.userImage.image = [UIImage imageNamed:@"logo"];
        }
    }else{
   
        self.mineHeaderView.userName.text = @"时间有限";
        self.mineHeaderView.userImage.image = [UIImage imageNamed:@"logo"];
      
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.view.backgroundColor = [UIColor whiteColor];
   self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, SCREEN_HEIGHT+20) style:UITableViewStylePlain];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
   [self.tableView registerNib:[UINib nibWithNibName:@"MineMessageCell" bundle:nil] forCellReuseIdentifier:MineMessageCell_ID];
   self.tableView.showsVerticalScrollIndicator = NO;
   [self.view addSubview:self.tableView];
   [self buildHeaderView]; // 创建头部视图
    UIWindow *windeo =  [UIApplication sharedApplication].keyWindow;
    self.vrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.vrBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.vrBtn setImage:[UIImage imageNamed:@"picture"] forState:UIControlStateNormal];
    self.vrBtn.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-100, 70, 70);
    [windeo addSubview:self.vrBtn];
//    [self setUpRefreshNews];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor:) name:@"changeBgColor" object:nil];
   LifeViewController*life = [[LifeViewController alloc]init];
   [self addChildViewController:life];
   self.phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
   [self.phoneBtn addTarget:self action:@selector(phoneBtnAction) forControlEvents:UIControlEventTouchUpInside];
   [self.phoneBtn setTitle:@" 随机电话\n6543人在玩" forState:UIControlStateNormal];
   self.phoneBtn.titleLabel.numberOfLines = 0;
   [self.phoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   self.phoneBtn.titleLabel.font = [UIFont systemFontOfSize:10];
   self.phoneBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, -20);
   [self.phoneBtn setBackgroundImage:[UIImage imageNamed:@"phoneblack"] forState:UIControlStateNormal];
   [windeo addSubview:self.phoneBtn];
   [self.phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(self);
      make.top.mas_equalTo(self).offset(180*Height);
   }];
   [self getMineGirlDataArray];
   self.userImage = @[[UIImage imageNamed:@"wu"],[UIImage imageNamed:@"peng"],[UIImage imageNamed:@"lu"],[UIImage imageNamed:@"liu"],[UIImage imageNamed:@"5.5"],[UIImage imageNamed:@"6.6"]];
   self.userName = @[@"吴亦凡",@"彭于晏",@"鹿晗",@"刘亦菲",@"胡歌",@"迪丽热巴"];
   self.userTitle =  @[@"嗨,最近看<战狼2>了吗?",@"halo,要来看我的演唱会吗?",@"[视频通话]",@"最近拍了一个新的视频,可以来看看吧",@"[语言聊天]",@"[语音聊天]"];
//   ManagerType
//   [self.manager POST:@"http://59.110.48.164:8001/SwitchHandler.ashx" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//      NSLog(@"%@",responseObject);
//      NSString *isOrNo = [NSString stringWithFormat:@"%@",responseObject[@"Result"]];
//      if ([isOrNo isEqual:@"0"]) {
//         self.mineHeaderView.btn4.hidden = YES;
//      }
//      if ([isOrNo isEqual:@"1"]) {
//         self.mineHeaderView.btn4.hidden = NO;
//      }
//      
//   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//      
//   }];
}
- (void)changeBgColor:(NSNotification *)notification{
    [self changeViewValue];
}
-(void)phoneBtnAction{
   UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"通话功能暂未开通哦" preferredStyle:UIAlertControllerStyleAlert];
   UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
   }];
   [alertVC addAction:confirm];
   [self presentViewController:alertVC animated:YES completion:nil];
}
-(void)buildHeaderView{
   self.mineHeaderView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220*Height)];
   [self.mineHeaderView.backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
   [self.mineHeaderView.btn4 addTarget:self action:@selector(chongzhi) forControlEvents:UIControlEventTouchUpInside];
   [self.mineHeaderView.btn6 addTarget:self action:@selector(nvyoudedian) forControlEvents:UIControlEventTouchUpInside];
   [self.mineHeaderView.joinUpVip addTarget:self action:@selector(shenqingDAREN) forControlEvents:UIControlEventTouchUpInside];
   self.tableView.tableHeaderView = self.mineHeaderView;
}

-(void)getMineGirlDataArray{
   ManagerType
   [self.manager POST:[UrlString stringByAppendingString:@"/VideosInterface/GetHandler.ashx"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      NSLog(@"%@",responseObject);
      self.mineHeaderView.MineGirlArray = [VedioModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
      [self.mineHeaderView.collevtiovView reloadData];
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      NSLog(@"%@",error);
   }];
}

//-(void)setUpRefreshNews{
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(buildUI)];
//    self.tableView.mj_footer.hidden = YES;
//}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.vrBtn.hidden = YES;
   self.phoneBtn.hidden = YES;
      [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)backBtnAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shenqingDAREN{
   BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
   if(isLogin){
      ShenQDRViewController *shenqing = [[ShenQDRViewController alloc]init];
      shenqing.titleName = self.mineHeaderView.userName.text;
      [self.navigationController pushViewController:shenqing animated:YES];
   }else{
      UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录账号!" preferredStyle:UIAlertControllerStyleAlert];
      
      UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         
      }];
      
      UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         SignInViewController *peoper = [[SignInViewController alloc]init];
         [self presentViewController:peoper animated:NO completion:nil];
      }];
      
      [alertVC addAction:cancel];
      [alertVC addAction:confirm];
      [self presentViewController:alertVC animated:YES completion:nil];
   }

   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return self.userImage.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   MineMessageCell*cell = [tableView dequeueReusableCellWithIdentifier:MineMessageCell_ID];
   cell.selectionStyle =UITableViewCellSelectionStyleNone;
   cell.userImage.image = self.userImage[indexPath.row];
   cell.userName.text = self.userName[indexPath.row];
   cell.userMessage.text = self.userTitle[indexPath.row];
   if (0 == indexPath.row % 3) {
      cell.userState.image = [UIImage imageNamed:@"have-time"];
   }else if (1 == indexPath.row % 3){
      cell.userState.image = [UIImage imageNamed:@"busy"];
   }else {
      cell.userState.image = [UIImage imageNamed:@"off-line"];
   }
   return cell;
}
-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return 70;
}

-(void)chongzhi{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    if(isLogin){
        ChongZhiViewController*moneyBag = [[ChongZhiViewController alloc]init];
       [self.navigationController pushViewController:moneyBag animated:YES];
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请登录账号!" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            SignInViewController *peoper = [[SignInViewController alloc]init];
            [self presentViewController:peoper animated:NO completion:nil];
        }];
        
        [alertVC addAction:cancel];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    
    
}

-(void)nvyoudedian{
    LifeViewController *shop = [[LifeViewController alloc]init];
    [self.navigationController pushViewController:shop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
