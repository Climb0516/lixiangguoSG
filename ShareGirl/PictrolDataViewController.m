//
//  PictrolDataViewController.m
//  V-show
//
//  Created by 姜鸥人 on 2017/7/11.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "PictrolDataViewController.h"

#import "TopView.h"
@interface PictrolDataViewController ()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger tag;
@property(nonatomic,strong)UILabel *progressLabel;
@property(nonatomic,strong)TopView *topView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation PictrolDataViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    if (self.imageDataArray.count >=1) {
        NSLog(@"有图");
    }else{
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示!" message:@"图片尚未更新,敬请期待!" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self backViewController];
        }];
        [alertVC addAction:confirm];
        [self presentViewController:alertVC animated:YES completion:nil];
    }

    
}
//仅设置当前页面
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor blackColor];

    self.tag = 1;
//    [self getImageDataArray];

    // 1.添加UISrollView
    [self setupScrollView];
    // 2.添加pageControl
    [self setupPageControl];
    // 添加头部
    [self setTopView];
    self.topView.hidden = YES;

}

// 1.添加UISrollView
-(void)setupScrollView{
    // 1.添加UISrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.frame = CGRectMake(0, 40, SCREEN_WIDTH , SCREEN_HEIGHT-40);
    [self.view addSubview:self.scrollView];
    self.scrollView.delegate =self;
   
    // 2.添加图片
//    CGFloat imageW = self.view.frame.size.width;
//    CGFloat imageH = self.view.frame.size.height;
    for (int i = 0; i < self.imageDataArray.count ; i++) {
        // 创建UIImageView
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapsAction:)];
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *imageURL = [self.imageDataArray[i] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
 
        [imageView  sd_setImageWithURL:[NSURL URLWithString:imageURL ]];
        
        [imageView addGestureRecognizer:tapGesture];
        [self.scrollView addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        // 设置frame
        imageView.frame =CGRectMake( i * SCREEN_WIDTH, 10, SCREEN_WIDTH, SCREEN_WIDTH*1.5+10);
//     imageView.frame =CGRectMake( i * self.scrollView.widht, 0, self.scrollView.widht, self.scrollView.height);
        self.scrollView.contentSize = CGSizeMake(self.imageDataArray.count * SCREEN_WIDTH, 0);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
    }
     [self.scrollView reloadInputViews];
}

// 2.添加pageControl
- (void)setupPageControl{

}

-(void)setTopView{
    self.topView = [[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    [self.topView.backBtn addTarget:self action:@selector(backViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.topView.backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.progressLabel = [[UILabel alloc] init];
//    self.progressLabel.backgroundColor = [UIColor redColor];
    self.progressLabel.textColor = [UIColor blackColor];
    self.progressLabel.text = [NSString stringWithFormat:@"%d/%lu", 1,(unsigned long)self.imageDataArray.count];
    self.progressLabel.font = [UIFont systemFontOfSize:15];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    [self.topView addSubview:self.progressLabel];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView.mas_centerX);
         make.centerY.equalTo(self.topView.mas_centerY).offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(50);
    }];
    
    [self.view addSubview:self.topView];
}
-(void)backViewController{

    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)TapsAction:(UITapGestureRecognizer *)tap{
//    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width , self.view.frame.size.height);
    if (self.tag == 1) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.topView.hidden = NO;
        self.tag = 0;
    } else {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
        self.topView.hidden = YES;
        self.tag = 1;
    }
        [self.view endEditing:YES];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger  number = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.progressLabel.text = [NSString stringWithFormat:@"%ld/%lu", number + 1,(unsigned long)self.imageDataArray.count];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
//    NSIndexPath *index =  [m_TableView indexPathForRowAtPoint:scrollView.contentOffset];
    NSInteger  number = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.progressLabel.text = [NSString stringWithFormat:@"%ld/%lu", number + 1,self.imageDataArray.count];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger  number = scrollView.contentOffset.x / [UIScreen mainScreen].bounds.size.width;
    self.progressLabel.text = [NSString stringWithFormat:@"%ld/%lu",number + 1,self.imageDataArray.count];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
