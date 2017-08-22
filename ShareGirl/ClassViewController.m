//
//  ClassViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/15.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ClassViewController.h"
#import "MostNewAndHotCell.h"
#import "VedioPlayViewController.h"
#import "MineViewController.h"
#import "VedioModel.h"
#import "ClassHeaderView.h"
#import "SDCycleScrollView.h"
#import "ClassCollectionCell.h"
#import "BannderModel.h"
#import "MineGirlModel.h"
#import "HomeCell.h"
#import "SignInViewController.h"
#import "ProduceModel.h"
@interface ClassViewController ()<UIGestureRecognizerDelegate,SDCycleScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource, ClassHeaderViewDelegate>
@property(nonatomic,strong)UIButton *mineBtn;
@property(nonatomic,strong)UIButton *message;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray *ImageArray;
@property(nonatomic,strong)NSMutableArray *VedioArray;
@property(nonatomic,strong)NSMutableArray *vedioURLArray;
@property(nonatomic,strong)ClassHeaderView *classView;
@property(nonatomic,strong)SDCycleScrollView *sdCycleView;
@property(nonatomic,strong)NSMutableArray *MineGArray;
@property(nonatomic,strong)NSMutableArray *bannerArray;
@property(nonatomic,strong)NSMutableDictionary *diction;
@property(nonatomic,strong)UIButton *phoneButton;
@end

@implementation ClassViewController
static NSString *const  headerViewIdentifier = @"hederviewView";
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIWindow *windeo =  [UIApplication sharedApplication].keyWindow;
    self.mineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mineBtn addTarget:self action:@selector(mineBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.mineBtn setImage:[UIImage imageNamed:@"newmy"] forState:UIControlStateNormal];
    self.mineBtn.frame = CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-100, 70, 70);
    [windeo addSubview:self.mineBtn];
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 20)/2, 250*Height);
    flowlayout.sectionInset =  UIEdgeInsetsMake(5, 5, 5, 5);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.minimumLineSpacing = 4;
    //1.3实例化UICollectionView 并设置flowLayout
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, -20,SCREEN_WIDTH , SCREEN_HEIGHT+20) collectionViewLayout:flowlayout];
    [self.collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:@"cell_id"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerViewIdentifier];
    // 配置属性
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    self.collectionView.tag = 10090;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    // 注册重用标志
    // 添加到父视图
    [self setUpRefreshNews];
    [self homeVedioArray];
    [self getMineGirlArray];
//    [self buildUI];
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    self.phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.phoneButton setImage:[UIImage imageNamed:@"b-phone"] forState:UIControlStateNormal];
    [self.view addSubview:self.phoneButton];

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (self.collectionView.contentOffset.y > 150) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:100 initialSpringVelocity:50 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    [UIView animateWithDuration:1 animations:^{
                        self.phoneButton.frame = CGRectMake(SCREEN_WIDTH-70, 150, 50, 50);
                    }];
        } completion:^(BOOL finished) {
            
        }];

    }else{
        [UIView animateWithDuration:0.5 delay:1 usingSpringWithDamping:100 initialSpringVelocity:50 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [UIView animateWithDuration:1 animations:^{
                self.phoneButton.frame = CGRectMake(SCREEN_WIDTH-70, -150, 50, 50);
            }];
        } completion:^(BOOL finished) {
            
        }];
    }
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.mineBtn.hidden = NO;
    self.message.hidden =NO;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.mineBtn.hidden = YES;
    self.message.hidden = YES;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
-(void)mineBtnAction{
    
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"];
    if(isLogin){
        self.mineBtn.hidden = YES;
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
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getVedioDataArray)];
    self.collectionView.mj_footer.hidden = YES;
}
-(void)getVedioDataArray{
    [self homeVedioArray];
    [self getMineGirlArray];
//    [self buildUI];
}

-(void)homeVedioArray{
    ManagerType
    [self.manager POST:[UrlString stringByAppendingString:@"/VideosInterface/GetHandler.ashx"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.VedioArray = [VedioModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
-(void)getMineGirlArray{
    ManagerType
    [self.manager POST:[UrlString stringByAppendingString:@"/ModelsInterface/GetHandler.ashx"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        self.MineGArray = [MineGirlModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        self.diction= [NSMutableDictionary dictionary];
        for (MineGirlModel *model in self.MineGArray) {
            [self.diction setObject:model.HeadImgUrl forKey:model.ID];
        }
         self.classView.modelArray = self.MineGArray;
         [self.classView.collevtiovView reloadData];
         [self.collectionView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    [self.manager POST:[UrlString stringByAppendingString:@"/ProductInterface/GetHandler.ashx"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"产品数组%@",responseObject);
        self.classView.proDuctArray = [ProduceModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        [self.classView.proDuctCollectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
// 轮播图
-(void)buildUI{
    ManagerType;
     self.ImageArray = [NSMutableArray array];
    [self.ImageArray removeAllObjects];
    NSString *httpUrl = [UrlString stringByAppendingString:@"/BannerInterface/GetHandler.ashx"];
    [self.manager POST:httpUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.bannerArray = [BannderModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        for (NSDictionary *dic  in responseObject[@"Data"]) {
            NSString *imgUrl  = dic[@"ImageUrl"];
            [self.ImageArray addObject:imgUrl];
        }
        self.sdCycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.classView.banderView.widht, self.classView.banderView.height) imageURLStringsGroup:self.ImageArray];
        self.sdCycleView.delegate =self;
        self.sdCycleView.backgroundColor = [UIColor whiteColor];
        [self.classView.banderView addSubview:self.sdCycleView];
        self.sdCycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.sdCycleView.pageControlDotSize = CGSizeMake(5, 5);
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
    }];
    

   }

//设置分区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

        return self.VedioArray.count;


}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{

    BannderModel *model = self.bannerArray[index];
    VedioPlayViewController *vedioView = [[VedioPlayViewController alloc]init];
        ManagerType
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:model.VideoId forKey:@"ID"];
    [self.manager POST:[UrlString stringByAppendingString:@"/VideosInterface/GetHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"轮播图%@",responseObject);
        for (NSDictionary *dic  in responseObject[@"Data"]) {
         vedioView.vedioURL = [dic[@"VideoUrlStand"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            vedioView.modelID = dic[@"ModelId"];
    }
        [self.navigationController pushViewController:vedioView animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
}
// 每个item的现实内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
        VedioModel *model = self.VedioArray[indexPath.row];
        //1.2去重用池查找cell_id(cell 重用标志放到viewDidLoad方法里注册)
        HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell_id" forIndexPath:indexPath];
        [cell.picImage sd_setImageWithURL:[NSURL URLWithString:[model.ImageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        cell.userLabel.text = model.Title;
    
    [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[[self.diction objectForKey:model.ModelId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        VedioModel *model = self.VedioArray[indexPath.row];
        VedioPlayViewController *vedioView = [[VedioPlayViewController alloc]init];
        vedioView.vedioURL = [model.VideoUrlStand stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        vedioView.modelID = model.ModelId;
        vedioView.userimage = model.ImageUrl;
        [self.navigationController pushViewController:vedioView animated:YES];
    
}


//创建头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header= [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIdentifier forIndexPath:indexPath];
        if (header.subviews.count == 0) {
        //如果是头视
            self.classView = [[ClassHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 490)];
            self.classView.delegate = self;
            [header addSubview: self.classView];
        }
        return header;
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
        return CGSizeMake(self.view.frame.size.width, 490);
}

- (void)push:(NSIndexPath *)indexPath {
        VedioPlayViewController *vedio = [[VedioPlayViewController alloc]init];
         MineGirlModel *model  =  self.MineGArray[indexPath.row];
        vedio.userimage = model.ImageUrl;
        vedio.modelName = model.Name;
        ManagerType
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setValue:model.ID forKey:@"ModelId"];
        [self.manager POST:[UrlString stringByAppendingString:@"/VideosInterface/GetHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.VedioArray = [VedioModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
            VedioModel *model = self.VedioArray[ arc4random() % self.VedioArray.count];
            vedio.vedioURL = model.VideoUrlStand;
            vedio.modelID = model.ModelId;

            [self.navigationController pushViewController:vedio animated:YES];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
}
- (void)pushProDuctControllerView:(NSIndexPath *)indenPath{
     VedioPlayViewController *vedio = [[VedioPlayViewController alloc]init];
     ProduceModel *model  =  self.classView.proDuctArray[indenPath.row];
     MineGirlModel *model1  =  self.MineGArray[0];
    vedio.vedioURL = [model.VideoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    vedio.userimage = model1.HeadImgUrl;
    [self.navigationController pushViewController:vedio animated:YES];
    
}
@end
