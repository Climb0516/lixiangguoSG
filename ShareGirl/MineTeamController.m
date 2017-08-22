//
//  MineTeamController.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/7.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "MineTeamController.h"
#import "DreamViewCell.h"
#import "TeamModel.h"
@interface MineTeamController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)DreamViewCell *dreamCell;
@property(nonatomic,strong)UIBarButtonItem *rightButton;


@property(nonatomic,strong)NSMutableArray *oneArray;
@property(nonatomic,strong)NSMutableArray *towArray;
@end

@implementation MineTeamController
static NSString * const dreamCell_id = @"dreamCell";
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我的团队";
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backController)];
    [self.navigationItem setLeftBarButtonItem:leftButton];

    self.tabbleViewOne.dataSource = self;
    self.tabbleViewOne.delegate =self;
    self.tabbleViewOne.tag = 6608;
    self.tabbleViewOne.showsVerticalScrollIndicator = NO;
    self.tabbleViewOne.showsHorizontalScrollIndicator = NO;
    self.tabbleViewOne.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tabbleViewTow.delegate =self;
    self.tabbleViewTow.dataSource =self;
     self.tabbleViewTow.tag = 6609;
    self.tabbleViewTow.showsVerticalScrollIndicator = NO;
    self.tabbleViewTow.showsHorizontalScrollIndicator = NO;
    self.tabbleViewTow.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self getOneArrayData];
//    [self getTowArrayData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self getOneArrayData];
//    [self getTowArrayData];
}
-(void)getOneArrayData{
    ManagerType
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:UserID forKey:@"ParentId"];
    [self.manager POST:[UrlString stringByAppendingString:@"/MemberInterface/GetFirstMemberHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         self.oneArray = [TeamModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        self.oneLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.oneArray.count];
        [self.tabbleViewOne reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}
-(void)getTowArrayData{
    ManagerType
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     [dic setValue:UserID forKey:@"ParentId"];
    [self.manager POST:[UrlString stringByAppendingString:@"/MemberInterface/GetAllMemberHandler.ashx"] parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
         self.towArray = [TeamModel mj_objectArrayWithKeyValuesArray:responseObject[@"Data"]];
        self.towLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.towArray.count];
        [self.tabbleViewTow reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.tag == 6608) {
        return 10;
    }
    if (tableView.tag == 6609) {
        return 10;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DreamViewCell * cell = [tableView dequeueReusableCellWithIdentifier:dreamCell_id];
    if (cell == nil) {
        cell = [[DreamViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dreamCell_id];
    }
//    if (tableView.tag == 6608) {
//        TeamModel *model = self.oneArray[indexPath.row];
//        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:model.LoginName]];
//        cell.userName.text = model.Name;
//        cell.labelType.text = model.Grade;
//        cell.numberLabel.text = model.Age;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    if (tableView.tag == 6609) {
//        TeamModel *model = self.towArray[indexPath.row];
//        [cell.userImage sd_setImageWithURL:[NSURL URLWithString:model.LoginName]];
//        cell.userName.text = model.Name;
//        cell.labelType.text = model.Grade;
//        cell.numberLabel.text = model.Age;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

-(void)backController{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
