//
//  ShenQDRViewController.m
//  ShareGirl
//
//  Created by 姜鸥人 on 2017/8/10.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "ShenQDRViewController.h"
#import "Order.h"
#import "APAuthV2Info.h"
#import "RSADataSigner.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DarenOneCell.h"
#import "DarenTowCell.h"
#import "DarenThereCell.h"
#import "DarenfourCell.h"
#import "BigGunHeaderView.h"
#import "MineTeamController.h"
#import "AddressViewController.h"
#import "DayTaskViewController.h"
#import "TiXianViewController.h"
@interface ShenQDRViewController ()
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)BigGunHeaderView *bigGunView;
@property(nonatomic,strong)AFHTTPSessionManager *manager;
@end

@implementation ShenQDRViewController
- (AFHTTPSessionManager *)manager{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleName;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(bcakView)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    self.titleArray = @[@"修改昵称",@"修改密码",@"我的邀请码",@"绑定手机",@"我的账单",@"申请提现",@"设置"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DarenOneCell" bundle:nil] forCellReuseIdentifier:@"DarenOneCell"];
        [self.tableView registerNib:[UINib nibWithNibName:@"DarenTowCell" bundle:nil] forCellReuseIdentifier:@"DarenTowCell"];
         [self.tableView registerNib:[UINib nibWithNibName:@"DarenThereCell" bundle:nil] forCellReuseIdentifier:@"DarenThereCell"];
         [self.tableView registerNib:[UINib nibWithNibName:@"DarenfourCell" bundle:nil] forCellReuseIdentifier:@"DarenfourCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIView *footerView = [[UIView alloc]init];
    footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    footerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = footerView;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"退出登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footerView.mas_centerX);
        make.centerY.mas_equalTo(footerView.mas_centerY);
    }];
      self.bigGunView = [[BigGunHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70*Height)];
    [self.bigGunView.teamButton addTarget:self action:@selector(teamButtonAction) forControlEvents:UIControlEventTouchUpInside];

    [self.bigGunView.incomeButton addTarget:self action:@selector(incomeButtonAction) forControlEvents:UIControlEventTouchUpInside];


    self.tableView.tableHeaderView = self.bigGunView;
    
}
-(void)bcakView{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)logoutAction{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示!" message:@"是否注销?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLogin"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"Mobile"];
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults]setValue:nil forKey:@"userID"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"isweixin"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isAddress"];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    [alertVC addAction:cancel];
    [alertVC addAction:confirm];
    [self presentViewController:alertVC animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 4) {
        return self.titleArray.count;
    }else{
        return 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        DarenOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DarenOneCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        return cell;
    }else if (indexPath.section == 1){
            DarenTowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DarenTowCell" forIndexPath:indexPath];
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.addMinePicButton addTarget:self action:@selector(addMinePicAction) forControlEvents:UIControlEventTouchUpInside];
              return cell;
        }else if (indexPath.section ==2){
           DarenThereCell*cell = [tableView dequeueReusableCellWithIdentifier:@"DarenThereCell" forIndexPath:indexPath];
       [cell.addMineVedioButton addTarget:self action:@selector(addMineVedioAction) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }else if (indexPath.section ==3){
            DarenfourCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DarenfourCell" forIndexPath:indexPath];
       [cell.addMineDreamButton addTarget:self action:@selector(addMineDreamAction) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell_id"];
            if (cell==nil) {
                cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id"];
            }
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = self.titleArray[indexPath.row];
            UIView *view = [[UIView alloc]init];
            view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
            [cell.contentView addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(cell.textLabel.mas_left);
                make.right.equalTo(cell.contentView);
                make.bottom.equalTo(cell.contentView);
                make.height.mas_equalTo(1);
            }];
            return cell;
        }
}
-(void)teamButtonAction{
    MineTeamController *mineTeam = [[MineTeamController alloc]init];
    [self.navigationController pushViewController:mineTeam animated:YES];
}

-(void)incomeButtonAction{
    DayTaskViewController *dayTask = [[DayTaskViewController alloc]init];
    [self.navigationController pushViewController:dayTask animated:YES];
}

-(void)addMinePicAction{
    
}
-(void)addMineVedioAction{
    
}
-(void)addMineDreamAction{
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 4 && indexPath.row == 0) {
        NSLog(@"昵称");
    }else if (indexPath.section == 4 && indexPath.row == 1){
        
    }else if (indexPath.section == 4 && indexPath.row == 2){
        
    }else if (indexPath.section == 4 && indexPath.row == 3){
        
    }else if (indexPath.section == 4 && indexPath.row == 4){
        
    }else if (indexPath.section == 4 && indexPath.row == 5){
        TiXianViewController *tixian = [[TiXianViewController alloc]init];
        [self.navigationController pushViewController:tixian animated:YES];
    }else if (indexPath.section == 4 && indexPath.row == 6){
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 130;
    }else if (indexPath.section == 1){
        return 160;
    }else if (indexPath.section == 2){
        return 120;
    }else if (indexPath.section ==3){
         return 120;
    }else{
        return 40;
    }
}
@end
