//
//  VedioPlayViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/12.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "VedioPlayViewController.h"
#import "MoreVeidoCell.h"
#import "MostNewAndHotCell.h"
#import "VedioPlayHeaderView.h"
#import "PictrolDataViewController.h"
#import "ProductViewController.h"
#import <UShareUI/UShareUI.h>
#import "VedioModel.h"
#import "ProduceModel.h"
#import "HomeCell.h"
#import "ZGLVideoPlyer.h"
#import "MineViewController.h"
#import "SignInViewController.h"
@interface VedioPlayViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,VedioPlayHeaderViewDelegate>


@property(nonatomic,weak)UIScrollView *contenView;
@property(nonatomic,strong)NSMutableArray *ImageArray;
@property(nonatomic,strong)NSMutableArray *proDuctArray;
@property(nonatomic,strong)UIImageView *userImage;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray *OtherVedioArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) ZGLVideoPlyer *player;
@property(nonatomic,strong)UIButton *vrBtn;
@property(nonatomic,strong)UIButton *backBtnAction;

@property(nonatomic,strong)NSMutableArray *otherTowArray;
@end

@implementation VedioPlayViewController

static NSString *const  headerViewIdentifier = @"hederviewViewView";
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
  UIWindow *windeo =  [UIApplication sharedApplication].keyWindow;

    
    self.backBtnAction = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtnAction addTarget:self action:@selector(backBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.backBtnAction setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.backBtnAction.frame = CGRectMake(5, 12, 30, 30);
    [windeo addSubview:self.backBtnAction];

    self.player = [[ZGLVideoPlyer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.783)];
    self.player.videoUrlStr = self.vedioURL;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti1) name:@"noti1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti2) name:@"noti2" object:nil];
    [self.view addSubview:self.player];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share-black"] style:UIBarButtonItemStylePlain target:self action:@selector(shareBtnAction)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.headerReferenceSize = CGSizeMake(0, SCREEN_HEIGHT/3+20);
    flowlayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20)/2, 300);
    flowlayout.sectionInset =  UIEdgeInsetsMake(5, 5, 5, 5);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumLineSpacing = 4;
    //1.3实例化UICollectionView 并设置flowLayout
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH/1.783, SCREEN_WIDTH, SCREEN_HEIGHT-SCREEN_WIDTH/1.783) collectionViewLayout:flowlayout];
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell_id"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
    // 配置属性
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
  
    self.vrBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.vrBtn addTarget:self action:@selector(gomineController) forControlEvents:UIControlEventTouchUpInside];
    [self.vrBtn setImage:[UIImage imageNamed:@"newmy"] forState:UIControlStateNormal];
    self.vrBtn.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-100, 70, 70);
    [windeo addSubview:self.vrBtn];

    [self setUpRefreshNews];
    [self getModelImageArray];
    [self getModelOtherVedio];
    [self getProdectArray];
//    ManagerType
//    [self.manager POST:@"http://59.110.48.164:8001/SwitchHandler.ashx" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
//        NSString *isOrNo = [NSString stringWithFormat:@"%@",responseObject[@"Result"]];
//        if ([isOrNo isEqual:@"0"]) {
//            self.vedioHeaderView.yuewoBtn.hidden = YES;
//            self.vedioHeaderView.vedioBtn.hidden = YES;
//        }
//        if ([isOrNo isEqual:@"1"]) {
//            self.vedioHeaderView.yuewoBtn.hidden = NO;
//            self.vedioHeaderView.vedioBtn.hidden = NO;
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//    }];
}

-(void)noti1{
    self.collectionView.hidden = YES;
      self.vrBtn.hidden = YES;
    self.backBtnAction.hidden = YES;
     [self prefersStatusBarHidden];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
}


-(void)noti2{
    self.collectionView.hidden = NO;
    self.vrBtn.hidden = NO;
    self.backBtnAction.hidden = NO;
     [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (BOOL)prefersStatusBarHidden{
        return YES;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
-(void)gomineController{
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    if(isLogin){
            MineViewController *mine = [[MineViewController alloc]init];
            [self.navigationController pushViewController:mine animated:YES];
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
-(void)setUpRefreshNews{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getNewArray)];
    self.collectionView.mj_footer.hidden = YES;
}
-(void)getNewArray{
    [self getModelImageArray];
      [self getModelOtherVedio];
    [self getProdectArray];
}

-(void)getModelImageArray{
    ManagerType
    self.ImageArray = [NSMutableArray array];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.modelID forKey:@"ModelId"];
    NSLog(@"%@",self.modelID);
    [self.manager POST:[UrlString stringByAppendingString:@"/PicturesInterface/GetHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        for (NSDictionary *dic in responseObject[@"Data"]) {
            NSString *imgUrl  = dic[@"ImageUrl"];
            [self.ImageArray addObject:imgUrl];
        }
        [self.vedioHeaderView.imageCollect reloadData];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
  
}

-(void)getModelOtherVedio{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    self.otherTowArray = [NSMutableArray array];
    [dic setValue:self.modelID forKey:@"ModelId"];
    [self.manager POST:[UrlString stringByAppendingString:@"/VideosInterface/GetHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
      self.OtherVedioArray = [VedioModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];

        self.otherTowArray = self.OtherVedioArray;
        
        self.vedioHeaderView.vedioArray = self.OtherVedioArray;
        
//        NSRange rang = {1,4};
//        [self.vedioHeaderView.vedioArray removeObjectsInRange:rang];
//               
        [self.vedioHeaderView.VoedioCollect reloadData];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)getProdectArray{
    self.proDuctArray = [NSMutableArray array];
    self.vedioHeaderView.proDuctArray = [NSMutableArray array];
    [self.manager POST:[UrlString stringByAppendingString:@"/ProductInterface/GetHandler.ashx"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"产品数组%@",responseObject);
        self.proDuctArray = [ProduceModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        self.vedioHeaderView.proDuctArray = self.proDuctArray;
    
        [self.vedioHeaderView.otherCollect reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}
-(void)backBtn{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)shareBtnAction{
        [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_Sina)]];
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            //创建网页内容对象
            NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"欢迎使用【友盟+】社会化组件U-Share" descr:@"欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！" thumImage:thumbURL];
            //设置网页地址
            shareObject.webpageUrl = self.vedioURL;
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
                if (error) {
                    UMSocialLogInfo(@"************Share fail with error %@*********",error);
                }else{
                    if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                        UMSocialShareResponse *resp = data;
                        //分享结果消息
                        UMSocialLogInfo(@"response message is %@",resp.message);
                        //第三方原始返回的数据
                        UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                        
                    }else{
                        UMSocialLogInfo(@"response data is %@",data);
                    }
                }
//                [self alertWithError:error];
            }];
        }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.player pause];
    self.backBtnAction.hidden = YES;
    self.vrBtn.hidden = YES;

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:YES animated:NO];
     self.vrBtn.hidden = NO;
     self.backBtnAction.hidden = NO;
     [self.player play];

}

//设置分区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.OtherVedioArray.count > 0) {
        return self.OtherVedioArray.count;
    }
    return 0;
}

// 每个item的现实内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VedioModel *model = self.OtherVedioArray[indexPath.row];
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
    [cell.picImage sd_setImageWithURL:[NSURL URLWithString:[model.ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    cell.userLabel.text = model.Title;
   [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[model.ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.player pause];
    VedioModel *model = self.OtherVedioArray[indexPath.row];
      self.player.videoUrlStr = model.VideoUrlStand;
    
}
//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header= [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        if (header.subviews.count == 0) {
            //如果是头视
            self.vedioHeaderView = [[VedioPlayHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 720)];
            [self.vedioHeaderView.userImage sd_setImageWithURL:[NSURL URLWithString:self.userimage]];
            [self.vedioHeaderView.yuewoBtn addTarget:self action:@selector(dateBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [self.vedioHeaderView.vedioBtn addTarget:self action:@selector(dateBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [self.vedioHeaderView.yuewoBtn setTitle:@" 语音通话\n0.8元/分钟" forState:UIControlStateNormal];
            [self.vedioHeaderView.vedioBtn setTitle:@" 视频聊天\n1.8元/分钟" forState:UIControlStateNormal];
            self.vedioHeaderView.imageArray = self.ImageArray;
            self.vedioHeaderView.proDuctArray = self.proDuctArray;
            self.vedioHeaderView.vedioArray = self.OtherVedioArray;
            self.vedioHeaderView.delegate = self;
            [header addSubview: self.vedioHeaderView];
        }
        return header;
    }
    return nil;
}

-(void)dateBtnAction{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"稍等片刻,即将开放哦!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];

    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 720);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20)/2, 250);
    
}
-(void)pushPicDateViewController{
         PictrolDataViewController *picData = [[PictrolDataViewController alloc]init];
            picData.imageDataArray = self.ImageArray;
            [self presentViewController:picData animated:NO completion:nil];
}
-(void)pushProductViewController:(NSIndexPath *)indexPath{
            ProduceModel *model = self.proDuctArray[indexPath.row];
//          ProductViewController *product = [[ProductViewController alloc]init];
//           product.vedioURL = [model.VideoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            product.proimageUrl = model.SmallImageUrl;
//            product.proName = model.Name;
//            product.proPrice = model.Price;
//            product.proContent = model.Introduction;
//            product.proID = model.ID;
//            [self.navigationController pushViewController:product animated:YES];
       [self.player pause];
//       VedioModel *model = self.OtherVedioArray[indexPath.row];
       self.player.videoUrlStr = [model.VideoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

-(void)pushVedioPlayViewController:(NSIndexPath *)indexPath{
    [self.player pause];
    VedioModel *model = self.OtherVedioArray[indexPath.row];
    self.player.videoUrlStr = model.VideoUrlStand;
    
}


@end
