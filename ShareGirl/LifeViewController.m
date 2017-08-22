//
//  LifeViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/17.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "LifeViewController.h"
#import "MoreVeidoCell.h"
#import "ProduceModel.h"
#import "ProductViewController.h"
@interface LifeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray *proDuctArray;
@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation LifeViewController
static NSString *VedioCell_id = @"VedioCell_id";

- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"梦想屋";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    UICollectionViewFlowLayout *flowlayout =[[UICollectionViewFlowLayout alloc]init];
    flowlayout.itemSize = CGSizeMake((SCREEN_WIDTH-20)/2, (SCREEN_WIDTH-10)/2);
    flowlayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowlayout.sectionInset =  UIEdgeInsetsMake(0, 5, 0, 5);
    flowlayout.minimumLineSpacing = 2;
    //1.3实例化UICollectionView 并设置flowLayout
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT) collectionViewLayout:flowlayout];
    [self.collectionView registerClass:[MoreVeidoCell class] forCellWithReuseIdentifier:VedioCell_id];
    // 配置属性
    self.collectionView.dataSource =self;
    self.collectionView.delegate =self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];

    // 添加刷新空间
        [self getVedioDataArray];
        [self setUpRefresh];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setUpRefresh{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getVedioDataArray)];
    self.collectionView.mj_footer.hidden = YES;
}
-(void)getVedioDataArray{
    ManagerType
    [self.manager POST:[UrlString stringByAppendingString:@"/ProductInterface/GetHandler.ashx"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"产品数组%@",responseObject);
        self.proDuctArray = [ProduceModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    
    {
        
    }];
}

//设置分区数
-(NSInteger )numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger )collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

        return self.proDuctArray.count;

    
}


// 每个item的现实内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MoreVeidoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VedioCell_id forIndexPath:indexPath];
    ProduceModel *model = self.proDuctArray[indexPath.row];
    NSString *string = [[NSString stringWithString:model.SmallImageUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"%@",model.SmallImageUrl);
    [cell.titleImage sd_setImageWithURL:[NSURL URLWithString:string]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProduceModel *model = self.proDuctArray[indexPath.row];
    ProductViewController *product = [[ProductViewController alloc]init];
    product.vedioURL = [model.VideoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    product.proimageUrl = model.SmallImageUrl;
    product.proName = model.Name;
    product.proPrice = model.Price;
    product.proContent = model.Introduction;
    product.proID = model.ID;
    [self.navigationController pushViewController:product animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
